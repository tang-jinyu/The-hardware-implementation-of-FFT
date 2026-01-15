# The-hardware-implementation-of-FFT
【正更新中ing...】

一、背景

博主是做加密芯片的，学习了FFT算法，就想着硬件实现

二、设计思想

由于32点的基2FFT蝶形运算需要进行80次蝶形运算，且每一级都是16次蝶形运算，若搭建80个蝶形单元会太浪费硬件资源并不合理。所以我们这个项目里采用时间换空间的思想，采用并行架构，只用到16个蝶形单元，每一级算完后将输出又输入到这16个蝶形单元的输入端，进行下一级的运算；当5次都算完后再进行输出

三、核心单元设计

1.加法器模块
由FFT表达式可知，因为分为奇数偶两个序列，但它们都是复数，把它们拆开用复数来表达，可以发现需要3个输入
<img width="1589" height="544" alt="image" src="https://github.com/user-attachments/assets/d7b44b7a-626f-42fc-be8e-50fb0b0f7326" />

2.乘法单元
①概述：由FFT表达式可以看到需要乘法单元；
②本乘法单元主要处理有符号的运算：通过最高位来判断是正数还是负数，如果是负数则用补码（取反加1）来计算
③核心技术处理：在这里通过截断高位和舍去低位来保持Q8.8的格式
<img width="765" height="406" alt="image" src="https://github.com/user-attachments/assets/8cd64301-4d2c-4ffa-ade6-2ca399cb4477" />

3.取反模块
由FFT表达式可以看到需要用到减法，而减法则用加上负数来表示【KEY：因为这个模块是纯组合逻辑，输出只依赖于输入而与时序无关，所以输入不用时钟和复位】
<img width="931" height="172" alt="image" src="https://github.com/user-attachments/assets/1eeb7674-ef26-4ba3-a643-b4deb8038d35" />

4.基2蝶形运算单元
根据FFT表达式，把输入和旋转因子都用复数表示并展开，发现需要用到加法、减法和乘法，所以将上面三个模块综合起来可以完成基2蝶形运算单元的搭建
<img width="1219" height="873" alt="image" src="https://github.com/user-attachments/assets/73a48bd1-0cc7-45b9-9349-946c8386c827" />

5.分频单元
本项目中计算模块运行频率是50MHz（20ns），因为一共有5级运算，所以进行5分频，整个周期为100ns，当5次计算完成后进行输出
