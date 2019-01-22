%清空变量，读取图像
clear;close all
template_rgb = imread('C:\Users\dell123\Documents\MATLAB\图像处理\eye.jpg');
src_rgb = imread('C:\Users\dell123\Documents\MATLAB\图像处理\head.jpg');

%转换为灰度图
template=rgb2gray(template_rgb);    template = im2double(template);
src=rgb2gray(src_rgb);  src = im2double(src);

figure('name','模板匹配结果'),
subplot(1,2,1),imshow(template_rgb),title('模板'),

%球的模板与原始图像的大小
tempSize=size(template);
tempHeight=tempSize(1); tempWidth=tempSize(2);
srcSize=size(src);
srcHeight=srcSize(1); srcWidth=srcSize(2);

%在图片的右侧与下侧补0
%By default, paddarray adds padding before the first element and after the last element along the specified dimension.
srcExpand=padarray(src,[tempHeight-1 tempWidth-1],'post');

%初始化一个距离数组 tmp:mj  template:x
%参见《数字图像处理》 Page561
distance=zeros(srcSize);
for height=1:srcHeight
   for width= 1:srcWidth
      tmp=srcExpand(height:(height+tempHeight-1),width:(width+tempWidth-1));
      %diff= template-tmp;
      %distance(height,width)=sum(sum(diff.^2));
      %计算决策函数
      distance(height,width)=sum(sum(template'*tmp-0.5.*(tmp'*tmp)));
   end
end

%寻找决策函数最大时的索引
maxDis=max(max(distance));
[x, y]=find(distance==maxDis);

%绘制匹配结果
subplot(1,2,2),imshow(src_rgb);title('匹配结果'),hold on
rectangle('Position',[x y tempWidth tempHeight],'LineWidth',2,'LineStyle','--','EdgeColor','r'),
hold off