%��ձ�������ȡͼ��
clear;close all
template_rgb = imread('C:\Users\dell123\Documents\MATLAB\ͼ����\eye.jpg');
src_rgb = imread('C:\Users\dell123\Documents\MATLAB\ͼ����\head.jpg');

%ת��Ϊ�Ҷ�ͼ
template=rgb2gray(template_rgb);    template = im2double(template);
src=rgb2gray(src_rgb);  src = im2double(src);

figure('name','ģ��ƥ����'),
subplot(1,2,1),imshow(template_rgb),title('ģ��'),

%���ģ����ԭʼͼ��Ĵ�С
tempSize=size(template);
tempHeight=tempSize(1); tempWidth=tempSize(2);
srcSize=size(src);
srcHeight=srcSize(1); srcWidth=srcSize(2);

%��ͼƬ���Ҳ����²ಹ0
%By default, paddarray adds padding before the first element and after the last element along the specified dimension.
srcExpand=padarray(src,[tempHeight-1 tempWidth-1],'post');

%��ʼ��һ���������� tmp:mj  template:x
%�μ�������ͼ���� Page561
distance=zeros(srcSize);
for height=1:srcHeight
   for width= 1:srcWidth
      tmp=srcExpand(height:(height+tempHeight-1),width:(width+tempWidth-1));
      %diff= template-tmp;
      %distance(height,width)=sum(sum(diff.^2));
      %������ߺ���
      distance(height,width)=sum(sum(template'*tmp-0.5.*(tmp'*tmp)));
   end
end

%Ѱ�Ҿ��ߺ������ʱ������
maxDis=max(max(distance));
[x, y]=find(distance==maxDis);

%����ƥ����
subplot(1,2,2),imshow(src_rgb);title('ƥ����'),hold on
rectangle('Position',[x y tempWidth tempHeight],'LineWidth',2,'LineStyle','--','EdgeColor','r'),
hold off