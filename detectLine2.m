close all;
load('I4.mat');
I = I4;
BW = I;
[H,T,R] = hough(BW);%�����ֵͼ��ı�׼����任��HΪ����任����I,RΪ�������任�ĽǶȺͰ뾶ֵ

imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');%hough�任��ͼ��