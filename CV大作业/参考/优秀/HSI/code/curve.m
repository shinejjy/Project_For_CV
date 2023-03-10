close all; clear;

im = imread('D:\QK\JNU\课程\机器学习课件\machine learning_qk\5k近邻与贝叶斯\shiyan5\code\HSI\kangaroo\kangaroo\HSI\0001.png');
im_rgb = imread('D:\QK\JNU\课程\机器学习课件\machine learning_qk\5k近邻与贝叶斯\shiyan5\code\HSI\kangaroo\kangaroo\HSI-FalseColor\0001.jpg');
im = X2Cube(im);
figure(1), imshow(im_rgb,[]);

for i =1:10
    figure(1)
    [x,y] = ginput(2);

    pos = round([y(1),x(1)]);%左上点坐标
    target_sz = round([y(2)-y(1),x(2)-x(1)]);%区域尺寸

J = im(pos(1):pos(1)+target_sz(1),pos(2):pos(2)+target_sz(2),:);
J_rgb = im_rgb(pos(1):pos(1)+target_sz(1),pos(2):pos(2)+target_sz(2),:);
P = mean(mean(J,1),2);%光谱曲线
P = P(:);
% figure, imshow(J_rgb,[])
figure(2),hold on,plot(P);%绘制曲线
% hold on
end