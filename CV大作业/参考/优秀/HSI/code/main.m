%% imshow HSI
close all; clear;
addpath('./X2Cube/X2Cube');%添加路径
%%
I=imread('D:\QK\JNU\课程\机器学习课件\machine learning_qk\5k近邻与贝叶斯\shiyan5\code\HSI\0101.png');
DataCube=X2Cube(I);
figure(1)
%% 显示16个波段
for i=1:16
    subplot(4,4,i)
    imshow(DataCube(:,:,i),[])
end


