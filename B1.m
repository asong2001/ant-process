%% 学长的代码提取角点图。MATLAB直接调用宏来处理CST的命
% 整合一下
% 图像优化和识别-江；
close all;

%% 读取资源
I0 = imread('2.jpg');
I0 = rot90(I0,-1);
I1 = rgb2gray(I0);
% I1 = imresize(I1,0.5,'bicubic');
I1 = double(I1);

I1 = 255-I1;
figure(1);imshow(I1,[]);

%% 去噪优化；并将识别到的角点转换为特殊位置上的集合...
    ...并取中间的均值作为该集合坐标
I2 = I1;
I2(I2<=100) = 0;
I2(I2>100) = 1;

% 可以进行更换
I3 = imclose(I2,strel('square',3));
I3 = imopen(I3,strel('square',10));

figure(2);imshow(I3,[]);

I4 = I3 - imerode(I3,strel('square',6));
figure(3);imshow(I4,[]);

%% 创建角点图
figure(4);
C = detectHarrisFeatures(I4);
imshow(I4),title('Corner角点图'),
hold on
plot(C.Location(:,1), C.Location(:,2), 'ro');
hold off

X = round(C.Location(:,2));
Y = round(C.Location(:,1));
I5 = zeros(size(I4));
for n = 1:size(X,1)
    I5(X(n),Y(n)) = 1;
end
I5 = imdilate(I5,strel('square',6));
% I5 = bwmorph(I5,'thin',inf);

I6 = bwlabel(I5);
figure(5);imshow(I6,[]);
I7 = zeros(size(I6));
for n = 1:max(I6(:))
    Ir = I6;
    Ir(Ir ~= n) = 0;
    Ir(Ir == n) = 1;
    [Irx,Iry] = find(Ir);
    Irmx = round(mean(Irx));
    Irmy = round(mean(Iry));
    I7(Irmx,Irmy) = 1;
end

%% 在笛卡尔坐标系计算边界
B = bwboundaries(I4);
xmax = max(B{1}(:,1));
xmin = min(B{1}(:,1));
ymax = max(B{1}(:,2));
ymin = min(B{1}(:,2));

L = 1;
W = 1;

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
title('Boundary points');

D = 1;
xD = x(1:D:end);
yD = y(1:D:end);
BpD{1} = Bp{1}(1:D:end,:);

Bound = BpD{1};
xx = x;
yy = y;

tmpX = [xx(2:end)' xx(1)];
tmpY = [yy(2:end)' yy(1)];
position = [xx yy tmpX' tmpY'];
figure;
for k = 1:length(position)
    xy1 = [position(k,1) position(k,3)];
    xy2 = [position(k,2) position(k,4)];
    line(xy1,xy2, 'LineWidth', 2);
    hold on
    % print(3,'-dbmp',sprintf('figure tmp/%d',k));
end