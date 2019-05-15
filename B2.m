%% ѧ���Ĵ�����ȡ�ǵ�ͼ��MATLABֱ�ӵ��ú�������CST����
% ���������ƽ�
% ����һ��
% ͼ���Ż���ʶ��-����
clc;
clear;
close all;

%% ��ȡ��Դ
I0 = imread('10.png');
I0 = rot90(I0,-1);
I1 = double(I0);
I1 = imresize(I1,0.5,'bicubic');
I1 = double(I1);

I1 = 255-I1;
figure(1);imshow(I1,[]);

%% ȥ���Ż�������ʶ�𵽵Ľǵ�ת��Ϊ����λ���ϵļ���...
    ...��ȡ�м�ľ�ֵ��Ϊ�ü�������
I2 = I1;
I2(I2<=100) = 0;
I2(I2>100) = 1;

% ���Խ��и���
I3 = imclose(I2,strel('square',3));
I3 = imopen(I3,strel('square',10));

figure(2);imshow(I3,[]);

% I4����׷�ٱ߽��
I4 = I3 - imerode(I3,strel('square',1));
figure(3);imshow(I4,[]);

%% ʹ�ùٷ�����ʶ��߽��
B = bwboundaries(I4);  % Trace region boundaries in binary image
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

% ������Ȧ�Ĳ�����
BpD{1} = Bp{1};
bound = BpD{1};
lenBound = length(bound);
lenBound = round(lenBound);

xx = x(1:lenBound,:);
yy = y(1:lenBound,:);

tmpX = [xx(2:end)' xx(1)];
tmpY = [yy(2:end)' yy(1)];
position = [xx yy tmpX' tmpY'];
figure;
t = 0;
for k = 1:length(position)
    xy1 = [position(k,1) position(k,3)];
    xy2 = [position(k,2) position(k,4)];
    line(xy1,xy2, 'LineWidth', 2);
    hold on
    % print(3,'-dbmp',sprintf('figure tmp/%d',k));
end