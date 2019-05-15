% 测试传递变量
clc;
clear;

load paraLine.mat;
src = zeros(length(paraLine), 6);
src(:, [1,2, 4,5]) = paraLine;
src = [src; src(1,:)];
lineNum = src;

[M,N] = size(src);
v = ones(1,N);
times = 5;% 倍率
tag = 1;
scaled_src = scale(src, times, tag);

para_src = scaled_src;% 用于创建变量的值
figure(1);
drawAntennaInMATLAB(para_src);

% 创建变量
lineNum = para_src;
para_list = [];
lineCount = [];
pointCount = [];
for k = 1:length(para_src)
        % k th line st point
        % ath 为第th条线段的起点；bth为终点
        eval(['line',num2str(k),'=','lineNum(k,:)',';']);
        lineName = ['line',num2str(k)];
        tmp = convertCharsToStrings(lineName);
        lineCount = [lineCount; tmp];
%         pointCount = [pointCount; pointTmp];
        
        % 创建变量名
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
        
        % 变量赋值
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

%% 假设移动line1
num = 1;
sel_line = convertCharsToStrings(sprintf('line%d',num));
sel_line_pos = 

%%% 啥啊，这个关系我还是没懂还是先去读取结果好了

