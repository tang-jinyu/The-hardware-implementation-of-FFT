import numpy as np
import matplotlib.pyplot as plt
import time

def bit_reverse_indices(N):
    bits = int(np.log2(N))
    indices = np.arange(N)
    reversed_indices = np.zeros(N,dtype=int)#传入一个数组，返回一个全0的数组

    for i in range(N):
        rev_i = 0
        temp = i
        for _ in range(bits):
            rev_i  = (rev_i << 1) | (temp & 1)
            temp >>=1
        reversed_indices[i] = rev_i

    return reversed_indices

def fft_iterative(x):
    N = len(x)

    if N & (N - 1) != 0:
        next_pow2 = 1 << (N - 1).bit_length()
        x_padded = np.pad(x, (0, next_pow2 - N), 'constant')
        result = fft_iterative(x_padded)
        return result[:N]
    
    # 0. 位逆序重排 (关键步骤!)
    rev_indices = bit_reverse_indices(N)
    X = x.copy()
    for i in range(N):
        rev_i = rev_indices[i]
        if i < rev_i:  # 只交换一次
            X[i], X[rev_i] = X[rev_i], X[i]

# 1. 迭代计算: 从最小粒度(2点DFT)开始，逐步合并
    step = 1  # 当前处理的DFT大小
    while step < N:
        # 对每个DFT块进行处理
        for k in range(0, N, 2 * step):
            # 对当前块内的每个元素进行蝶形运算
            for j in range(step):
                idx1 = k + j
                idx2 = k + j + step
                
                # 计算旋转因子
                angle = -2j * np.pi * j / (2 * step)
                W = np.exp(angle)
                
                # 蝶形运算 (与递归法中的相同运算!)
                t = X[idx2] * W
                X[idx2] = X[idx1] - t
                X[idx1] = X[idx1] + t            
        step *= 2  # 处理更大的DFT块
    
    return X                

fs = 1024  # 采样频率，同时为点数：①它是2的幂次；②有奈奎斯特采样定理：应该大于最高信号的2倍（这里是40）,1024Hz远高于此
t = np.linspace(0, 1, fs, endpoint=False)  # 时间向量
signal = np.sin(2 * np.pi * 5 * t) + 0.5 * np.sin(2 * np.pi * 20 * t)

my_result = fft_iterative(signal)
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
plt.subplot(3,1,3)
plt.plot(freqs,np.abs(my_result))
plt.title('Frequency Domain Signal(my FFT)')
plt.xlabel('Frequency [Hz]')
plt.ylabel('Magnitude')
plt.xlim(0,50)
plt.grid(True)

plt.tight_layout()
plt.show()
