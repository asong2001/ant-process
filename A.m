%��ձ�������ȡͼ��  
clear;close all
src = imread('D:\������\ͼ����\2.png');

%��ʾԭͼ��
subplot(2,2,1),imshow(src),title('ԭͼ��')

%��ostu������ȡ��ֵ����ֵ�����ж�ֵ����������ʾ
level=graythresh(src);
bw=im2bw(src,level);

%���ÿ�������ȥ���
se = strel('disk',1);
openbw=imopen(bw,se);
subplot(2,2,2),imshow(openbw),title('ȥ������ֵ��ͼ')

bw1 = edge(openbw,'canny',[0 , 50/256]); %��ȡ�߽� 
dilateElement=strel('square',2);  
bw2=imdilate(bw1, dilateElement);  
subplot(2,2,3),imshow(bw2),title('��Եͼ')

C = detectHarrisFeatures(openbw);
subplot(2,2,4),imshow(src),title('Corner�ǵ�ͼ'),
hold on

plot(C.Location(:,1), C.Location(:,2), 'r*');

hold off







