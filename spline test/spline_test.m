% spline test
clc;
clear;
close all;

% ����2.png������
load coordinate_of_2jpg.mat
srcX = position(1:end,1);
srcY = position(1:end,2);

% [1]https://blog.csdn.net/Mr_Grit/article/details/45603627
% ���ƶ���P
P = [srcX srcY];
flag = 1;

opt_P = spline_approach(P, flag);

figure;
for k = 1:length(P);
    