%% ��ʾ�������� �Ƚϲ�ͬ����Ĺ������߲��

close all;clear all;
im = imread('0101.png');
addpath('D:\QK\JNU\�γ�\����ѧϰ�μ�\machine learning_qk\5k�����뱴Ҷ˹\shiyan5\code\X2Cube\X2Cube');
im = X2Cube(im);% ԭʼ��ά�����ת��Ϊ��ά���ݣ��׶�����Ϊ16
imshow(im(:,:,1),[])

%% pos = [1,1];%���ϵ�����
pos = ginput(1);% �������ȡͼ���ж�Ӧ���ص�λ��
target_sz = [2,2];%����ߴ�

J = im(pos(1):pos(1)+target_sz(1),pos(2):pos(2)+target_sz(2),:);
P = mean(mean(J,1),2);%��������
P = P(:);
figure(5)
plot(P);%��������
hold on
%%
figure(1)
pos = ginput(1);
target_sz = [2,2];%����ߴ�

J = im(pos(1):pos(1)+target_sz(1),pos(2):pos(2)+target_sz(2),:);
P = mean(mean(J,1),2);%��������
P = P(:);
figure(5)
plot(P);%��������
%%
figure(1)
pos = ginput(1);
target_sz = [2,2];%����ߴ�

J = im(pos(1):pos(1)+target_sz(1),pos(2):pos(2)+target_sz(2),:);
P = mean(mean(J,1),2);%��������
P = P(:);
figure(5)
plot(P);%��������
