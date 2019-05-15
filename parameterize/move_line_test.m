clc;
clear;
close all;

%% 测试移动线的功能
load paraLine.mat;
src = zeros(length(paraLine), 6);
src(:, [1,2, 4,5]) = paraLine;
src = [src; src(1,:)];
lineNum = src;

%% 计算位移参数
lineNumToMove = 21;
lineToMove = src(lineNumToMove,:);
dim = 2;
stepLength =2;
normalVector = lineNormalVector(lineToMove, dim);
newLinek = moveLine(-normalVector, lineToMove, stepLength,dim);
newSrc = updateMoveLine(src, newLinek, lineNumToMove, dim);

%% 查看结果
[M,N] = size(src);
v = ones(1,N);

times = 1;
tag = 1;
scaled_src = scale(src, times, tag);
para_src = scaled_src;% 用于创建变量的值
figure(100);
color = 'Blue';
drawAntennaInMATLAB(para_src, color);
axis equal;
hold on;

color = 'Red';
drawAntennaInMATLAB(newSrc, color);