%% ��������������ʾһ��Ԫ�أ�����CST�������������������м��ֱ��
clc;
clear;
close all;

% ��ȡͼƬ
src = imread('6.jpg');

% ��ʾԭͼ��
imshow(src);
title('ԭͼ��');

% ��ostu������ȡ��ֵ����ֵ�����ж�ֵ����������ʾ
level = graythresh(src);
bw = im2bw(src,level);

%% ������
se = strel('disk',1);
openbw = imopen(bw,se);
figure(1);
imshow(openbw),title('ȥ������ֵ��ͼ');

%% ��ȡ�߽�
bw1 = edge(openbw,'canny',[0 , 50/256]);
dilateElement = strel('square',2);  

bw2 = imdilate(bw1, dilateElement);  
% bw2 = imopen(bw2, strel('disk',1));  

figure(2);
imshow(bw2),title('��Եͼ');

%% �ڵѿ�������ϵ����߽�
B = bwboundaries(bw2);
xmax = max(B{1}(:,1));
xmin = min(B{1}(:,1));
ymax = max(B{1}(:,2));
ymin = min(B{1}(:,2));


%% �����ǵ�ͼ
figure;
C = detectHarrisFeatures(bw2);
imshow(bw2),title('Corner�ǵ�ͼ'),
hold on
plot(C.Location(:,1), C.Location(:,2), 'r*');
hold off

% ��׽ֱ��
detectLine(bw2);
    
%% ͨ��������������������
fileName = '.\position file\position_0.txt';
xyD = [C.Location(:,1) C.Location(:,2)];
% Write data to text file
P = (xyD);
P = [P ; P(1,:)];
dlmwrite(fileName,P);
type(fileName);

% modelling(xyD);


%% �������ص㣬����ʾ���ص�
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

%% �������ص㣬�²���
D = 50;     % ��������
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

%% ���弸�νṹ
% ���ݱ߽���λ������������
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

