%% 参考学长的例子看一下能不能够自动化完成
clc;
clear;
close all;

% read image
src = imread('official.jpg');

% show original image
subplot(221);
imshow(src);
title('原始图像');

% 用ostu方法获取二值化阈值，进行二值化并进行显示
level = graythresh(src);
bw = im2bw(src,level);

%运用开操作消去噪点
se = strel('disk',1);
openbw=imopen(bw,se);
subplot(2,2,2),imshow(openbw),title('去噪声二值化图')

bw1 = edge(openbw,'canny',[0 , 50/256]); %获取边界 
dilateElement=strel('square',2);  
bw2=imdilate(bw1, dilateElement);  
subplot(2,2,3),imshow(bw2),title('边缘图')

C = detectHarrisFeatures(openbw);
subplot(2,2,4),imshow(src),title('Corner角点图'),
hold on

plot(C.Location(:,1), C.Location(:,2), 'r*');

hold off