%% shiyan2 DoG滤波 20230309
clear;
close all;
%% 
%% DoG
f=imread('plane.jpg');
I=rgb2gray(f);

sigma1=0.1;
sigma2=0.8;
window=7;
H1=fspecial('gaussian', window, sigma1);
H2=fspecial('gaussian', window, sigma2);
 
DiffGauss=H1-H2;
out=imfilter(I,DiffGauss,'replicate');
out=mat2gray(out);
figure;imshow(out);
%%
