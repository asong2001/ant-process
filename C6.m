%% 用六个坐标来表示一个元素，导入CST，即用两个点的坐标和中间的直线
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
% bw2 = imopen(bw2, strel('disk',1));  

figure(2);
imshow(bw2),title('边缘图');

%% 在笛卡尔坐标系计算边界
B = bwboundaries(bw2);
xmax = max(B{1}(:,1));
xmin = min(B{1}(:,1));
ymax = max(B{1}(:,2));
ymin = min(B{1}(:,2));


%% 创建角点图
figure;
C = detectHarrisFeatures(bw2);
imshow(bw2),title('Corner角点图'),
hold on
plot(C.Location(:,1), C.Location(:,2), 'r*');
hold off

% 捕捉直线
detectLine(bw2);
    
%% 通过输入坐标来创建天线
fileName = '.\position file\position_0.txt';
xyD = [C.Location(:,1) C.Location(:,2)];
% Write data to text file
P = (xyD);
P = [P ; P(1,:)];
dlmwrite(fileName,P);
type(fileName);

% modelling(xyD);


%% 放缩像素点，并显示像素点
%{
L = 1;
W = 1;
% L = 18.61e-3;
% W = 72.27e-3;
LperColpixel = L/(xmax-xmin);
WperRowpixel = W/(ymax-ymin);
Bp = B;
for i = 1:length(Bp)
    Bp{i} = [Bp{i}(:,1).*LperColpixel Bp{i}(:,2).*WperRowpixel zeros(size(Bp{i},1),1)];
end

p = cell2mat(Bp);
x = p(:,1);
y = p(:,2);
figure(3);
plot(x,y,'*')
grid on
axis equal
xlabel('x (m)')
ylabel('y (m)')
title('Boundary points');

%% 减少像素点，下采样
D = 50;     % 采样点数
xD = x(1:D:end);
yD = y(1:D:end);
BpD{1} = Bp{1}(1:D:end,:);
figure(4)
hold on
plot(xD,yD,'r*');
% for k = 1:length(xD)
%     plot(xD(k),yD(k),'r*');
%     pause(0.5);
% end
shg
grid on
axis equal
%}

%% 定义几何结构
% 根据边界点的位置来创建天线
%{
c = customAntennaGeometry;
c.Boundary = BpD;
c.Operation = 'P1';
c.FeedLocation = [0.0185 0.0392 0];
c.FeedWidth = 0.25e-3;
figure
show(c)
view(0,90)
%}

