% ����һ��
% ͼ���Ż���ʶ��-����
close all;

%% ��ȡ��Դ
I0 = imread('2.jpg');
I0 = rot90(I0,-1);
I1 = rgb2gray(I0);
% I1 = imresize(I1,0.5,'bicubic');
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

I4 = I3 - imerode(I3,strel('square',6));
figure(3);imshow(I4,[]);

%% �����ǵ�ͼ
figure(4);
C = detectHarrisFeatures(I4);
imshow(I4),title('Corner�ǵ�ͼ'),
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

%% �ǵ���
C2 = detectHarrisFeatures(I7);

figure(6);
% �����������Ľǵ�ͼ����˳��
title('�ǵ�ͼ��������꣩');
plot(C2.Location(:,1), C2.Location(:,2), 'ro');

%% ����λ����������
X = C2.Location(:,1);
Y = C2.Location(:,2);

% pos ���괦��
pos = [X Y];
tmp1 = [pos(:,1) pos(:,2)];
tmp2 = tmp1;
% ����x2��y2
tmp2(1:end-1,:) = pos(2:end,:);
tmp2(end,:) = pos(1,:);
position = [tmp1 tmp2];     % position = [x1 y1 x2 y2]


%% ����Hough�㷨ֱ�Ӷ�ֱ�߽��м��
peakNum = length(position);     % ��ֵ�������
lines = detectLine(I4,peakNum * 2);

figure;
title('Line detected by Hough');
imshow(I4), hold on;
for k = 1:length(lines)
    xy = [lines(k).point1; lines(k).point2];
    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');%�����߶�
    plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');%���
    plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');%�յ�
    
    file_name = ['D:\������\ͼ����\ant-process\figure\',num2str(k),'.png'];
    saveas(gcf,file_name);
end

%% Write data to text file
fileName = '.\position file\position_0.txt';
dlmwrite(fileName,pos);
type(fileName);