close all;
load('I4.mat');
I = I4;
BW = I;
[H,T,R] = hough(BW);%计算二值图像的标准霍夫变换，H为霍夫变换矩阵，I,R为计算霍夫变换的角度和半径值

imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');%hough变换的图像