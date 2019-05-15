% spline test
clc;
clear;
close all;

% 输入2.png的坐标
load coordinate_of_2jpg.mat
srcX = position(1:end,1);
scrY = position(1:end,2);

%% [1]https://blog.csdn.net/Mr_Grit/article/details/45603627 样条逼近
% 控制定点P
P = [srcX scrY];
flag = 1;

opt_P = spline_approach(P, flag);

%% 平行直线判定
[lenP, ~] = size(opt_P);
lines = [];
lineIndex = 0;
for k = 2:lenP-1
    % 还没有直线的情况
    if k == 2
        lines = [opt_P(k-1, :) opt_P(k, :)];% 判断的直线
        start_point = lines(1,1:2);
        end_point = lines(1,3:4);
        lineIndex = lineIndex + 1;
        lastLine = [start_point end_point];
%         [numOfLine,~] = size(lines);%已知直线
        numOfLine = 1;
    else 
        % 已经产生直线，并开始新一轮循环的时候
        [numOfLine,~] = size(lines);
        start_point = lines(numOfLine,1:2);
        end_point = opt_P(k+1,1:2);
        lastLine = [start_point end_point];
    end

    % 选择新的直线
    newLineTmp = [opt_P(k, :) opt_P(k+1, :)];
    new_start_p = newLineTmp(1,1:2);
    new_end_p = newLineTmp(1,3:4);
    
     
    % 判断直线重合
    isOverlap = line_overlap(lastLine, newLineTmp);% 三点共线，围成的的三角形面积=0

    % 追加直线
    if isOverlap == true
        tmp = [start_point new_end_p];
        lines(numOfLine,3:4) = new_end_p;
        disp('Extend the straight line');
        figure(2);
        line(lines(numOfLine,1:2),lines(numOfLine,3:4));
    else
        lineIndex = lineIndex + 1;
        tmp = zeros(1,4);
        tmp(1,1:2) = new_start_p;
        tmp(1,3:4) = new_end_p;
        lines = [lines; tmp];
        disp('add new line');
    end
end
