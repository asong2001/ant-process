%��ձ�������ȡͼ�񣬲���ʾ������
clear;close all
src = imread('C:\Users\dell123\Documents\MATLAB\ͼ����\rice.jpg');
whos,

%��ʾԭʼͼ��
figure('name','myapp'),
subplot(2,2,1),imshow(src),title('src')

%��ostu������ȡ��ֵ����ֵ�����ж�ֵ����������ʾ
level=graythresh(src);
bw=im2bw(src,level);
subplot(2,2,2),imshow(bw),title('bw');

%���ÿ�������ȥ���
se = strel('disk',1);
openbw=imopen(bw,se);
subplot(2,2,3),imshow(openbw),title('open')

%��ȡ��ͨ���򣬲�������ʾ
L = bwlabel(openbw,4);%bwlabelʹ��һ�����������Ϊ1,�ڶ�����ͨ�����Ϊ2,�Դ�����
RGB = label2rgb(L);
subplot(2,2,4),imshow(RGB),title('rgb')

%��ȡ�����'basic'���ԣ� 'Area', 'Centroid', and 'BoundingBox' 
stats = regionprops(openbw, 'basic');
centroids = cat(1, stats.Centroid);
figure('name','regionprops'),
%���ƿ�����֮��Ķ�ֵ��ͼ��
imshow(openbw),title('centroids')  
hold on
%��������
plot(centroids(:,1), centroids(:,2), 'b*'),
%���Ƹ���Ȥ����ROI
for i=1:size(stats)
     rectangle('Position',[stats(i).BoundingBox],'LineWidth',2,'LineStyle','--','EdgeColor','r'),
end
hold off