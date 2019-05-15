%% 使用官方的例子进行模仿。
% https://ww2.mathworks.cn/help/antenna/examples/antenna-model-generation-and-full-wave-analysis-from-a-photo.html?requestedDomain=zh

% clc;
% clear;
close all;

%% 引入蒙版和图片。这一步产生的蒙版图层（create_segement）是使用了手动标记的
I = imread('official.jpg');
BWf = createMask_4PNG(I);   % input RGB of the antenna image
figure
imshow(BWf)

%% 在笛卡尔坐标系内计算边界
B = bwboundaries(BWf);
xmax = max(B{1}(:,1));
xmin = min(B{1}(:,1));
ymax = max(B{1}(:,2));
ymin = min(B{1}(:,2));

% 放缩像素点
L = 18.61e-3;
W = 72.27e-3;
LperColpixel = L/(xmax-xmin);
WperRowpixel = W/(ymax-ymin);
Bp = B;
for i = 1:length(Bp)
    Bp{i} = [Bp{i}(:,1).*LperColpixel Bp{i}(:,2).*WperRowpixel zeros(size(Bp{i},1),1)];
end
p = cell2mat(Bp);
x = p(:,1);
y = p(:,2);
figure
plot(x,y,'*')
grid on
axis equal
xlabel('x (m)')
ylabel('y (m)')
title('Boundary points')

%% 减少像素点，下采样
D = 39;     % 采样点数
xD = x(1:D:end);
yD = y(1:D:end);
BpD{1} = Bp{1}(1:D:end,:);
figure
hold on
plot(xD,yD,'r*')
shg
grid on
axis equal

%% 定义几何结构
% 根据边界点的位置来创建天线
c = customAntennaGeometry;
c.Boundary = BpD;
c.Operation = 'P1';
c.FeedLocation = [0.0185 0.0392 0];
c.FeedWidth = 0.25e-3;
figure
show(c)
view(0,90)

%% 创建馈点
sf1 = antenna.Rectangle('Length', 5e-3, 'Width', 2e-3,                  ...
                        'Center', [0.019 0.0392]);
c.Boundary = [BpD(1) {getShapeVertices(sf1)}];
c.Operation = 'P1-P2';
figure
show(c)
view(0,90)

sf = antenna.Rectangle('Length', 0.25e-3, 'Width', 2e-3,               ...
                       'Center', [0.0185 0.0392]);
c.Boundary = [BpD(1) {getShapeVertices(sf1)} {getShapeVertices(sf)}];
c.Operation = 'P1-P2+P3';
figure
show(c)
view(0,90)

%% 分析馈电情况和阻抗
f_coarse = linspace(0.8e9,0.95e9,21);
figure
impedance(c,f_coarse)

X = -1i*200;
zl = lumpedElement;
zl.Impedance = X;
c.Load = zl;

%% 重新计算阻抗
f_fine = linspace(0.8e9,0.95e9,51);
figure
impedance(c,f_fine)

figure
current(c,854e6)

figure
pattern(c,854e6)