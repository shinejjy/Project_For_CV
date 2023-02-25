%% shiyan2 图像滤波 20230224
close all
%% help filter2 
%% 均值滤波
f=imread('plane.jpg');
I=rgb2gray(f);
J=imnoise(I,'salt',0.02);
figure(11),subplot(2,2,1),imshow(I),title('原图像');
subplot(2,2,2),imshow(J),title('加入椒盐噪声的图像');
K1=filter2(fspecial('average',3),J)/255;%3*3均值滤波处理结果
K2=filter2(fspecial('average',5),J)/255;%5*5均值滤波处理结果
subplot(2,2,3),imshow(K1),
title('3*3均值滤波处理结果');
subplot(2,2,4),imshow(K2),
title('5*5均值滤波处理结果');

%% 高斯 维纳

 J=imnoise(I,'gaussian',0,0.005);
 h=fspecial('gaussian');
 K=filter2(h,J)/255;
 K1=wiener2(J,[5,5]);
 figure(2),subplot(2,2,1),imshow(I),title('原图像');
 subplot(2,2,2),imshow(J),title('加入高斯噪声的图像');
 subplot(2,2,3),imshow(K),title('高斯低通滤波的结果');
 subplot(2,2,4),imshow(K1),title('维纳滤波后的结果');
 
%% unsharp算子

h=fspecial('laplacian');
I2=filter2(h,I);
figure(3),subplot(2,2,2),imshow(I),title('灰度图像');
subplot(2,2,1),imshow(I),title('原图像');
subplot(2,2,3),imshow(I2),title('拉普拉斯算子滤波后的结果'); %采用'unsharp'算子实现对比度增强滤波器
h=fspecial('unsharp',0.5);
I3=filter2(h,I)/255;
figure(3),subplot(2,2,4),imshow(I3),
title('unsharp算子实现对比度增强滤波后的结果');

%%  Sobel滤波

 h1=fspecial('sobel');
 I2=filter2(h1,I);%sobel卷积
 I3=conv2(I,h1);
 h2=fspecial('prewitt');
 I4=filter2(h2,I);
 h3=fspecial('log');
 I5=filter2(h3,I);
 figure(4),
subplot(2,2,1),imshow(I),title('原图像');
 subplot(2,2,2),imshow(I3);
title('sobel滤波');
subplot(2,2,3),imshow(I4);
title('prewitt滤波');
subplot(2,2,4),imshow(I5);
title('log滤波');






 