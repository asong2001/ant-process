%% 学长的代码提取角点图。MATLAB直接调用宏来处理CST的命令

clc;
clear;
close all;

% 读取图片
src = imread('6.jpg');

% 显示原图像
imshow(src);
title('原图像');

% 用ostu方法获取二值化阈值，进行二值化并进行显示
level = graythresh(src);
bw = im2bw(src,level);

%% 起初噪点
se = strel('disk',1);
openbw = imopen(bw,se);
figure(1);
imshow(openbw),title('去噪声二值化图');

%% 获取边界
bw1 = edge(openbw,'canny',[0 , 50/256]);
dilateElement = strel('square',2);  
bw2 = imdilate(bw1, dilateElement);  
figure(2);
imshow(bw2),title('边缘图');

%% 在笛卡尔坐标系计算边界
B = bwboundaries(bw2);
xmax = max(B{1}(:,1));
xmin = min(B{1}(:,1));
ymax = max(B{1}(:,2));
ymin = min(B{1}(:,2));


%% 创建角点图
figure(3);
C = detectHarrisFeatures(openbw);
imshow(src),title('Corner角点图'),
hold on
plot(C.Location(:,1), C.Location(:,2), 'r*');

%% 通过输入坐标来创建天线
fileName = '.\position file\p.txt';
xyD = [C.Location(:,1) C.Location(:,2)];
% Write data to text file
P = (xyD);
P = [P ; P(1,:)];
dlmwrite(fileName,P);
type(fileName);

%% 创建位置坐标数组
pos = load('.\position file\p.txt');
tmp1 = [pos(:,1) pos(:,2)];
tmp2 = tmp1;
% 操作x2，y2
tmp2(1:end-1,:) = pos(2:end,:);
tmp2(end,:) = pos(1,:);
position = [tmp1 tmp2];     % position = [x1 y1 x2 y2]

%% 改用Hough算法直接对直线进行检测
I4 = bw2;
peakNum = length(pos);     % 极值点的数量
lines = detectLine(I4, peakNum);

figure;
title('Line detected by Hough');
imshow(I4), hold on;
for k = 1:length(lines)
    xy = [lines(k).point1; lines(k).point2];
    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');%画出线段
    plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');%起点
    plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');%终点
end

%% 通过两个点来确定一条线段实现图像复原
% figure(3);
% title('点线图');
% for k = 1:length(position)
%     xy1 = [position(k,1) position(k,3)];
%     xy2 = [position(k,2) position(k,4)];
%     line(xy1,xy2, 'LineWidth', 2);
%     pause(0.5);
%     
%     % print(3,'-dbmp',sprintf('figure tmp/%d',k));
% end

%% 建模的程序有问题，先在matlab里面测试位置的程序

%% 启动建模操作
% modelling(position);
% modelling2()
