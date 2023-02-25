%% shiyan1 加噪声 20230224

%% help imnoise 

f=imread('plane.jpg');
g=rgb2gray(f);
g1=imnoise(g,'gaussian',0.251,0.00615);% 均值64 方差400 的高斯噪声
subplot(1,2,1);imshow(g)
title('原图');
subplot(1,2,2);imshow(g1)
title('噪声图');

%% 写出其它噪声添加，并对比显示