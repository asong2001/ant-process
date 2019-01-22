%��ձ�������ȡͼ��
clear;close all
RGB = imread('C:\Users\dell123\Documents\MATLAB\ͼ����\test.jpg');

figure('name','process'),
subplot(2,2,1),imshow(RGB),title('ԭʼRGB'),

%convert frame from RGB to YCBCR colorspace��ת����YCBCR�ռ䣩
YCBCR = rgb2ycbcr(RGB);

subplot(2,2,2),imshow(YCBCR),title('YCBCR'),
%filter YCBCR image between values and store filtered image to threshold
%matrix���ø���ͨ������ֵ������ж�ֵ������
Y_MIN = 0;  Y_MAX = 256;
Cb_MIN = 100;   Cb_MAX = 127;
Cr_MIN = 138;   Cr_MAX = 170;
threshold=roicolor(YCBCR(:,:,1),Y_MIN,Y_MAX)&roicolor(YCBCR(:,:,2),Cb_MIN,Cb_MAX)&roicolor(YCBCR(:,:,3),Cr_MIN,Cr_MAX);
subplot(2,2,3),imshow(threshold),title('YCBCR��ֵ��'),

%perform morphological operations on thresholded image to eliminate noise
%and emphasize the filtered object(s)��������̬ѧ������ʴ�����͡��׶���䣩
erodeElement = strel('square', 3) ;
dilateElement=strel('square', 8) ;
threshold = imerode(threshold,erodeElement);
threshold = imerode(threshold,erodeElement);
threshold=imdilate(threshold, dilateElement);
threshold=imdilate(threshold, dilateElement);
threshold=imfill(threshold,'holes');
subplot(2,2,4),imshow(threshold),title('��̬ѧ����'),

%��ȡ�����'basic'���ԣ� 'Area', 'Centroid', and 'BoundingBox' 
figure('name','������'),
stats = regionprops(threshold, 'basic');
[C,area_index]=max([stats.Area]);
%��λ��������
face_locate=[stats(area_index).Centroid(1),stats(area_index).Centroid(2)];
imshow(RGB);title('after'),hold on
text(face_locate(1),face_locate(2)-40,  'face','color','red');
plot(face_locate(1),face_locate(2), 'b*');
rectangle('Position',[stats(area_index).BoundingBox],'LineWidth',2,'LineStyle','--','EdgeColor','r'),
hold off