%% Canny算法 20230309

clc;clear;close all;
%% 图片导入与预处理
f_original=imread('plane.jpg');
f_grey = rgb2gray(f_original);%转换为灰度图像

%% CANNY算子边缘检测
%% 1-高斯滤波
gw = fspecial('gaussian',[5,5],0.5);%高斯滤波设置核，5*5，标准差为0.5
f_filter = imfilter(f_grey,gw,'replicate');%高斯滤波
f = f_filter;

%% 2-利用Sobel算子计算像素梯度
Sobel_X = [-1,0,1;-2,0,2;-1,0,1]; %X方向Sobel算子(互相关算子，非卷积算子)
Sobel_Y = [-1,-2,-1;0,0,0;1,2,1]; %Y方向Sobel算子(互相关算子)
[rowNum,columnNum] = size(f);
f_extend = zeros(rowNum+2,columnNum+2);%图像扩充，边界补充为0
for  i = 2:rowNum+1
    for j = 2:columnNum+1
        f_extend(i,j) = f(i-1,j-1);
    end
end
Gx = zeros(rowNum,columnNum);
Gy = zeros(rowNum,columnNum);
for i = 2:rowNum+1   %计算x向和y向梯度
    for j = 2:columnNum+1
        window = [f_extend(i-1,j-1),f_extend(i-1,j),f_extend(i-1,j+1);...
            f_extend(i,j-1),f_extend(i,j),f_extend(i,j+1);...
            f_extend(i+1,j-1),f_extend(i+1,j),f_extend(i+1,j+1)];
        Gx(i-1,j-1) = sum(sum(Sobel_X .* window));  %计算x向梯度
        Gy(i-1,j-1) = sum(sum(Sobel_Y .* window));  %计算y向梯度
    end
end

Sxy = sqrt(Gx.*Gx + Gy.*Gy); %梯度强度矩阵计算

%% 3-非极大值抑制
indexD = zeros(rowNum,columnNum);
for i = 1:rowNum   %判断梯度方向所属区间，Gx=Gy=0，则令其为5，肯定不是边界点
    for j = 1:columnNum
        ix = Gx(i,j);
        iy = Gy(i,j);
        if (iy<=0 && ix>-iy) || (iy>=0 && ix<-iy)          %梯度方向属于区间1
            indexD(i,j) = 1;
        elseif (ix>0 && ix<=-iy) || (ix<0 && ix>=-iy)      %梯度方向属于区间2
            indexD(i,j) = 2;
        elseif (ix<=0 && ix>iy) || (ix>=0 && ix<iy)        %梯度方向属于区间3
            indexD(i,j) = 3;
        elseif (iy<0 && ix<=iy) || (iy>0 && ix>=iy)        %梯度方向属于区间4
            indexD(i,j) = 4;
        else                                               %Gx和Gy均为0，无梯度，肯定非边缘
            indexD(i,j) = 5;
        end
    end
end

Gup = zeros(rowNum,columnNum);
Gdown = zeros(rowNum,columnNum);
for i = 2:rowNum-1   %计算非边界处的插值梯度强度
    for j = 2:columnNum-1
        ix = Gx(i,j);
        iy = Gy(i,j);
        if indexD(i,j) == 1 %计算区间1内插值梯度，Gup为上方区间的梯度，Gdown为下方区间的梯度
            t = abs(iy./ix);
            Gup(i,j) = Sxy(i,j+1).*(1-t) + Sxy(i-1,j+1).*t;
            Gdown(i,j) = Sxy(i,j-1).*(1-t) + Sxy(i+1,j-1).*t;
        elseif indexD(i,j) == 2                                   %计算区间2内插值梯度
            t = abs(ix./iy);
            Gup(i,j) = Sxy(i-1,j).*(1-t) + Sxy(i-1,j+1).*t;
            Gdown(i,j) = Sxy(i+1,j).*(1-t) + Sxy(i+1,j-1).*t;
        elseif indexD(i,j) == 3                                   %计算区间3内插值梯度
            t = abs(ix./iy);
            Gup(i,j) = Sxy(i-1,j).*(1-t) + Sxy(i-1,j-1).*t;
            Gdown(i,j) = Sxy(i+1,j).*(1-t) + Sxy(i+1,j+1).*t;
        elseif indexD(i,j) == 4                                   %计算区间4内插值梯度
            t = abs(iy./ix);
            Gup(i,j) = Sxy(i,j-1).*(1-t) + Sxy(i-1,j-1).*t;
            Gdown(i,j) = Sxy(i,j+1).*(1-t) + Sxy(i+1,j+1).*t;
        end
    end
end

Sxy_NMX = zeros(rowNum,columnNum);                            %判断是否为梯度方向极大值
for i = 1:rowNum                                     
    for j = 1:columnNum
        if Sxy(i,j) >= Gup(i,j) && Sxy(i,j) >= Gdown(i,j)     %若为梯度方向极大值，则保留；
            Sxy_NMX(i,j) = Sxy(i,j);                          %否则，进行抑制（置0）
        end
    end
end
    
%% 4-滞后阈值法+5-抑制孤立的弱边缘
f_final = zeros(rowNum,columnNum);
%% 自己设定
Tl = 15;   
Th = 35;
%%
connectNum = 1;

for i = 2:rowNum-1                                     
    for j = 2:columnNum-1
        if Sxy_NMX(i,j) >= Th          %高于高阈值的像素为强边缘
            f_final(i,j) = 1;
        elseif Sxy_NMX(i,j) <= Tl      %低于低阈值的像素为非边缘
            f_final(i,j) = 0;
        else                           %位于高低阈值之间的像素为弱边缘，进行孤立性检测
            count = 0;
            if Sxy_NMX(i-1,j-1)~=0     %左上方像素
                count = count+1;
            end
            if Sxy_NMX(i-1,j)~=0       %上方像素
                count = count+1;
            end
            if Sxy_NMX(i-1,j+1)~=0     %右上方像素
                count = count+1;
            end
            if Sxy_NMX(i,j-1)~=0       %左方像素
                count = count+1;
            end
            if Sxy_NMX(i,j+1)~=0       %右方像素
                count = count+1;
            end
            if Sxy_NMX(i+1,j-1)~=0     %左下方像素
                count = count+1;
            end
            if Sxy_NMX(i+1,j)~=0       %下方像素
                count = count+1;
            end
            if Sxy_NMX(i+1,j+1)~=0     %右下方像素
                count = count+1;
            end
            if count >= connectNum     %弱边缘非孤立，则为边缘
                f_final(i,j) = 1;
            end
        end
    end
end

%% MATLAB的CANNY算子边缘检测
[fCanny_dafault,tc] = edge(f_grey,'canny');%使用默认参数
%%
subplot(1,3,1);
imshow(f_original);
title('原始图像','fontsize',10);
subplot(1,3,2);
imshow(f_final);
title('Canny边缘检测','fontsize',10);
subplot(1,3,3);
imshow(fCanny_dafault);
title('MATLAB内置Canny边缘检测','fontsize',10);


