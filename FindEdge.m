 %��ձ�������ȡͼ��  
clear;close all  
src = imread('C:\Users\dell123\Documents\MATLAB\ͼ����\antenna.jpg');  
  
figure('name','ԭʼͼ��'),  
imshow(src),title('src'),  
  
%Convert to grayscale  
gray=rgb2gray(src); gray = im2double(gray);  
  
%Convert to binary image using Canny   
bw = edge(gray,'canny',[0 , 50/256]); %��ȡ�߽� 
  
%dilate  
dilateElement=strel('square', 5);  
bw=imdilate(bw, dilateElement);  
  
%��ȡÿ����ͨ����  
stats = regionprops(bw, 'Image');  
statssize= numel(stats);  
plotsize=ceil(sqrt(statssize));  
figure('name','������'),  
num=zeros(statssize,1);  
%�㷨����  
for i=1:statssize  
    image=stats(i).Image;  
    %����ϸ������  
    im=bwmorph(image,'thin',Inf);  
    % getting the edge data.   
    edgelist=bwboundaries(im);edgelist=edgelist.';  
    % calling linefit_Prasad_RDP_opt  
    [edgelist,seglist,precision_list,reliability_list,precision_edge,reliability_edge, time_edge] = linefit_Prasad_RDP_opt(edgelist);  
    boundnum=length(seglist{1}(:,:));  
    bound=0;  
    sizepic=sum(size(im));  
    %�ж�ÿ������֮��ļ���Ƿ����Ҫ��  
    for j=1:boundnum-1  
        cornerdiff=seglist{1}(j,:)-seglist{1}(j+1,:);  
        cornerdiff=sqrt(sum(cornerdiff.^2));  
        if(cornerdiff>0.09*sizepic)  
            bound=bound+1;  
        end  
    end  
    num(i)=bound;  
    %���л�ͼ����ʶ  
    subplot(plotsize,plotsize,i);imshow(image),  
    if bound<7  
        title(bound);  
    else  
        title('Բ');  
    end  
end  