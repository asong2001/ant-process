% ���Դ��ݱ���
clc;
clear;

load paraLine.mat;
src = zeros(length(paraLine), 6);
src(:, [1,2, 4,5]) = paraLine;
src = [src; src(1,:)];
lineNum = src;

[M,N] = size(src);
v = ones(1,N);
times = 5;% ����
tag = 1;
scaled_src = scale(src, times, tag);

para_src = scaled_src;% ���ڴ���������ֵ
figure(1);
drawAntennaInMATLAB(para_src);

% ��������
lineNum = para_src;
para_list = [];
lineCount = [];
pointCount = [];
for k = 1:length(para_src)
        % k th line st point
        % ath Ϊ��th���߶ε���㣻bthΪ�յ�
        eval(['line',num2str(k),'=','lineNum(k,:)',';']);
        lineName = ['line',num2str(k)];
        tmp = convertCharsToStrings(lineName);
        lineCount = [lineCount; tmp];
%         pointCount = [pointCount; pointTmp];
        
        % ����������
        paraTmp = [...
                convertCharsToStrings(sprintf('ax%d',k))...
                convertCharsToStrings(sprintf('ay%d',k))...
                convertCharsToStrings(sprintf('bx%d',k))...
                convertCharsToStrings(sprintf('by%d',k))...
                ];
        para_list = [para_list; paraTmp];
        
        eval(['ax',num2str(k) '=', num2str(para_src(k,1)),';']);
        eval(['ay',num2str(k) '=', num2str(para_src(k,2)),';']);
        eval(['bx',num2str(k) '=', num2str(para_src(k,4)),';']);
        eval(['by',num2str(k) '=', num2str(para_src(k,5)),';']);
        
        % ������ֵ
        X1 = ['ax',num2str(k)];
        Y1 = ['ay',num2str(k)];
        X2 = ['bx',num2str(k)];
        Y2 = ['by',num2str(k)];
        
        l = lineNum(k,:);
        ax = l(1);
        ay = l(2);
        bx = l(4);
        by = l(5);
end

%% �����ƶ�line1
num = 1;
sel_line = convertCharsToStrings(sprintf('line%d',num));
sel_line_pos = 

%%% ɶ���������ϵ�һ���û��������ȥ��ȡ�������

