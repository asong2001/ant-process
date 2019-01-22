 %清空变量，读取图像  
clear;close all  
src = imread('C:\Users\dell123\Documents\MATLAB\图像处理\antenna.jpg');  
  
figure('name','原始图像'),  
imshow(src),title('src'),  
  
%Convert to grayscale  
gray=rgb2gray(src); gray = im2double(gray);  
  
%Convert to binary image using Canny   
bw = edge(gray,'canny',[0 , 50/256]); %获取边界 
  
%dilate  
dilateElement=strel('square', 5);  
bw=imdilate(bw, dilateElement);  
  
%提取每个连通区域  
stats = regionprops(bw, 'Image');  
statssize= numel(stats);  
plotsize=ceil(sqrt(statssize));  
figure('name','分离结果'),  
num=zeros(statssize,1);  
%算法核心  
for i=1:statssize  
    image=stats(i).Image;  
    %进行细化操作  
    im=bwmorph(image,'thin',Inf);  
    % getting the edge data.   
    edgelist=bwboundaries(im);edgelist=edgelist.';  
    % calling linefit_Prasad_RDP_opt  
    [edgelist,seglist,precision_list,reliability_list,precision_edge,reliability_edge, time_edge] = linefit_Prasad_RDP_opt(edgelist);  
    boundnum=length(seglist{1}(:,:));  
    bound=0;  
    sizepic=sum(size(im));  
    %判断每个顶点之间的间距是否符合要求  
    for j=1:boundnum-1  
        cornerdiff=seglist{1}(j,:)-seglist{1}(j+1,:);  
        cornerdiff=sqrt(sum(cornerdiff.^2));  
        if(cornerdiff>0.09*sizepic)  
            bound=bound+1;  
        end  
    end  
    num(i)=bound;  
    %进行绘图并标识  
    subplot(plotsize,plotsize,i);imshow(image),  
    if bound<7  
        title(bound);  
    else  
        title('圆');  
    end  
end  