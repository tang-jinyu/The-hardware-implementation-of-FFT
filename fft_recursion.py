import numpy as np
import matplotlib.pyplot as plt

def my_fft(x):
    
    N = len(x)
    
    if N == 1:
        return x
    elif N == 2:
        return np.array([x[0] + x[1],x[0] - x[1]])
    #检测长度是否为2的幂
    if N & (N - 1) != 0:#因为如果是2的幂次，则其二进制只有一个1，而n-1的二进制表示是低位全1，按位与的结果为0
        # 计算下一个2的幂
        next_pow2 = 1 << (N - 1).bit_length()#计算≥N的最小2的幂，bit_length()表示返回会表示一个数需要的位数
        # 用零填充到下一个2的幂的长度
        x_padded = np.pad(x, (0, next_pow2 - N), 'constant')#在数组x的末尾填充0使其长度达到next_pow2
        # 对填充后的序列做FFT，然后截取前N个结果（近似）
        return my_fft(x_padded)[:N]#只返回前N个点（原始长度）
    
    #1.分解：分离偶数和奇数索引样本 
    even = my_fft(x[0::2])#从索引0开始 ，步长为2，即：提取偶数
    odd  = my_fft(x[1::2])#从索引1开始 ，步长为2，即：提取奇数

    #2.组合：应用蝶形运算
    #Ⅰ生成旋转因子
    k = np.arange(N // 2)#创建等差数组，代表生成一个从0到N/2-1的整数数组
    W = np.exp(-2j * np.pi * k/N)

    #Ⅱ蝶形运算x[k]=E[k]+W_N^k *O[k],X[k+N/2]=E[K]-W_N^k *O[k]
    first_half = even + W *odd
    second_half = even - W * odd

    #Ⅲ拼接结果
    return np.concatenate([first_half,second_half])

#========测试FFT实现========#
fs = 1024  # 采样频率，同时为点数：①它是2的幂次；②有奈奎斯特采样定理：应该大于最高信号的2倍（这里是40）,1024Hz远高于此
t = np.linspace(0, 1, fs, endpoint=False)  # 时间向量
signal = np.sin(2 * np.pi * 5 * t) + 0.5 * np.sin(2 * np.pi * 20 * t)


#以8点为例
#test_signal = np.array([1,2,3,4,5,6,7,8],dtype=complex)

#使用自己的实现
my_result = my_fft(signal)
np_result = np.fft.fft(signal)

#计算轴率
freqs = np.fft.fftfreq(fs,1/fs)
plt.figure(figsize=(12,10))

#时域信号
plt.subplot(3,3,1)
plt.plot(t,signal)
plt.title('Time Domain Signal')
plt.xlabel('Time [s]')
plt.ylabel('Amplitude')
plt.grid(True)

#频域信号
plt.subplot(3,1,2)
plt.plot(freqs,np.abs(np_result))
plt.title('Frequency Domain Signal(Numpy FFT)')
plt.xlabel('Frequency [Hz]')
plt.ylabel('Magnitude')
plt.xlim(0,50)
plt.grid(True)

#频域信号
plt.subplot(3,1,3)
plt.plot(freqs,np.abs(my_result))
plt.title('Frequency Domain Signal(my FFT)')
plt.xlabel('Frequency [Hz]')
plt.ylabel('Magnitude')
plt.xlim(0,50)
plt.grid(True)

plt.tight_layout()
plt.show()

idx_5 = np.argmin(np.abs(freqs - 5))
idx_20 = np.argmin(np.abs(freqs - 20))
print("关键频率点幅度对比：")
print(f"5Hz:  NumPy FFT = {np.abs(np_result[idx_5]):.2f}, My FFT = {np.abs(my_result[idx_5]):.2f}")
print(f"20Hz: NumPy FFT = {np.abs(np_result[idx_20]):.2f}, My FFT = {np.abs(my_result[idx_20]):.2f}")

print("输入信号：",signal)
print("\n我的fft：",my_result)
print("Numpy FFT：",np_result)
print("\n最大绝对误差：",np.max(np.abs(my_result - np_result)))