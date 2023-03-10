%% 显示光谱曲线 比较不同物体的光谱曲线差别

close all;clear all;
im = imread('0101.png');
addpath('D:\QK\JNU\课程\机器学习课件\machine learning_qk\5k近邻与贝叶斯\shiyan5\code\X2Cube\X2Cube');
im = X2Cube(im);% 原始二维多光谱转换为三维数据，谱段数量为16
imshow(im(:,:,1),[])

%% pos = [1,1];%左上点坐标
pos = ginput(1);% 点击鼠标获取图像中对应像素点位置
target_sz = [2,2];%区域尺寸

J = im(pos(1):pos(1)+target_sz(1),pos(2):pos(2)+target_sz(2),:);
P = mean(mean(J,1),2);%光谱曲线
P = P(:);
figure(5)
plot(P);%绘制曲线
hold on
%%
figure(1)
pos = ginput(1);
target_sz = [2,2];%区域尺寸

J = im(pos(1):pos(1)+target_sz(1),pos(2):pos(2)+target_sz(2),:);
P = mean(mean(J,1),2);%光谱曲线
P = P(:);
figure(5)
plot(P);%绘制曲线
%%
figure(1)
pos = ginput(1);
target_sz = [2,2];%区域尺寸

J = im(pos(1):pos(1)+target_sz(1),pos(2):pos(2)+target_sz(2),:);
P = mean(mean(J,1),2);%光谱曲线
P = P(:);
figure(5)
plot(P);%绘制曲线
