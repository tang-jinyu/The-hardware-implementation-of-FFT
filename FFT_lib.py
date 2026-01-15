import numpy as np#导入numpy库并把它简称np，是用于科学计算的核心库，可以做点乘卷积等运算
import matplotlib.pyplot as plt#是主要的绘画和可视化的库

#生成信号
t = np.linspace (0,1,1000,endpoint=False)#创建时间轴数组，从0开始1结束，均匀生成1000个点，endpoint=false：不包括终点1，避免采样两个一样的点
x = np.sin(2 * np.pi * 5 * t) + 0.5 * np.sin(2 * np.pi * 20 * t)#创建合成信号，由两个正弦波叠加，一个频率5振幅1，一个频率20振幅0.5，x是与t等长的数组，表示每个时间点对应的信号幅值域

#进行FFT
X = np.fft.fft(x)#对时域信号进行fft,X是一个复数数组，包含信号现在频域中的幅度和相位信息

#计算轴率
N = len(x)#获取信号长度
f = np.fft.fftfreq(N,  t[1] -t[0])#生成与FFT结果对应的频率轴，N是数据点数，d是采样之间的时间间隔

#绘制时域信号
plt.figure(figsize=(12,6))
plt.subplot(2,1,1)
plt.title('Time domain signal')
plt.xlabel('Time[s]')
plt.ylabel('Ampitude')
plt.plot(t,x)

#绘制频域信号
plt.subplot(2,1,2)
plt.plot(f,np.abs(X))#取复数的模
plt.title('Frequency domain signal')
plt.xlabel('Frequency [Hz]')
plt.ylabel('Magnitude')
plt.tight_layout()
plt.show()