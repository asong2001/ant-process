% spline test
clc;
clear;
close all;

% ����2.png������
load coordinate_of_2jpg.mat
srcX = position(1:end,1);
scrY = position(1:end,2);

%% [1]https://blog.csdn.net/Mr_Grit/article/details/45603627 �����ƽ�
% ���ƶ���P
P = [srcX scrY];
flag = 1;

opt_P = spline_approach(P, flag);

%% ƽ��ֱ���ж�
[lenP, ~] = size(opt_P);
lines = [];
lineIndex = 0;
for k = 2:lenP-1
    % ��û��ֱ�ߵ����
    if k == 2
        lines = [opt_P(k-1, :) opt_P(k, :)];% �жϵ�ֱ��
        start_point = lines(1,1:2);
        end_point = lines(1,3:4);
        lineIndex = lineIndex + 1;
        lastLine = [start_point end_point];
%         [numOfLine,~] = size(lines);%��ֱ֪��
        numOfLine = 1;
    else 
        % �Ѿ�����ֱ�ߣ�����ʼ��һ��ѭ����ʱ��
        [numOfLine,~] = size(lines);
        start_point = lines(numOfLine,1:2);
        end_point = opt_P(k+1,1:2);
        lastLine = [start_point end_point];
    end

    % ѡ���µ�ֱ��
    newLineTmp = [opt_P(k, :) opt_P(k+1, :)];
    new_start_p = newLineTmp(1,1:2);
    new_end_p = newLineTmp(1,3:4);
    
     
    % �ж�ֱ���غ�
    isOverlap = line_overlap(lastLine, newLineTmp);% ���㹲�ߣ�Χ�ɵĵ����������=0

    % ׷��ֱ��
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
