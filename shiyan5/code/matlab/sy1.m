%% shiyan1 拉普拉斯 20230309
clear;close all;
%% help imfilter 

f=imread('plane.jpg');
I=rgb2gray(f);
%% 自带函数
imshow(I);
mask=[0,1,0;1,-4,1;0,1,0];%拉普拉斯滤波模板
C=imfilter(I,mask,'replicate');
figure(2),imshow(C,[]);

%% 原始方法
% [M,N]=size(I);
% B=zeros(size(I));
% for x=2:M-1
%     for y=2:N-1
%         B(x,y)=I(x+1,y)+I(x-1,y)+I(x,y+1)+I(x,y-1)-4*I(x,y);
%     end
% end
% figure(1);
% subplot(121);imshow(I);
% subplot(122);imshow(B,[]);