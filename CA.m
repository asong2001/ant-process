%% ѧ���Ĵ�����ȡ�ǵ�ͼ��MATLABֱ�ӵ��ú�������CST������

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
figure(2);
imshow(bw2),title('��Եͼ');

%% �ڵѿ�������ϵ����߽�
B = bwboundaries(bw2);
xmax = max(B{1}(:,1));
xmin = min(B{1}(:,1));
ymax = max(B{1}(:,2));
ymin = min(B{1}(:,2));


%% �����ǵ�ͼ
figure(3);
C = detectHarrisFeatures(openbw);
imshow(src),title('Corner�ǵ�ͼ'),
hold on
plot(C.Location(:,1), C.Location(:,2), 'r*');

%% ͨ��������������������
fileName = '.\position file\p.txt';
xyD = [C.Location(:,1) C.Location(:,2)];
% Write data to text file
P = (xyD);
P = [P ; P(1,:)];
dlmwrite(fileName,P);
type(fileName);

%% ����λ����������
pos = load('.\position file\p.txt');
tmp1 = [pos(:,1) pos(:,2)];
tmp2 = tmp1;
% ����x2��y2
tmp2(1:end-1,:) = pos(2:end,:);
tmp2(end,:) = pos(1,:);
position = [tmp1 tmp2];     % position = [x1 y1 x2 y2]

%% ����Hough�㷨ֱ�Ӷ�ֱ�߽��м��
I4 = bw2;
peakNum = length(pos);     % ��ֵ�������
lines = detectLine(I4, peakNum);

figure;
title('Line detected by Hough');
imshow(I4), hold on;
for k = 1:length(lines)
    xy = [lines(k).point1; lines(k).point2];
    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');%�����߶�
    plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');%���
    plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');%�յ�
end

%% ͨ����������ȷ��һ���߶�ʵ��ͼ��ԭ
% figure(3);
% title('����ͼ');
% for k = 1:length(position)
%     xy1 = [position(k,1) position(k,3)];
%     xy2 = [position(k,2) position(k,4)];
%     line(xy1,xy2, 'LineWidth', 2);
%     pause(0.5);
%     
%     % print(3,'-dbmp',sprintf('figure tmp/%d',k));
% end

%% ��ģ�ĳ��������⣬����matlab�������λ�õĳ���

%% ������ģ����
% modelling(position);
% modelling2()
