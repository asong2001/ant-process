%清空变量，读取图像  
clear;close all
src = imread('D:\课题组\图像处理\2.png');

%显示原图像
subplot(2,2,1),imshow(src),title('原图像')

%用ostu方法获取二值化阈值，进行二值化并进行显示
level=graythresh(src);
bw=im2bw(src,level);

%运用开操作消去噪点
se = strel('disk',1);
openbw=imopen(bw,se);
subplot(2,2,2),imshow(openbw),title('去噪声二值化图')

bw1 = edge(openbw,'canny',[0 , 50/256]); %获取边界 
dilateElement=strel('square',2);  
bw2=imdilate(bw1, dilateElement);  
subplot(2,2,3),imshow(bw2),title('边缘图')

C = detectHarrisFeatures(openbw);
subplot(2,2,4),imshow(src),title('Corner角点图'),
hold on

plot(C.Location(:,1), C.Location(:,2), 'r*');

hold off







