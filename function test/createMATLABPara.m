% 创建CST中的变量
function [para_list,lineCount] = createMATLABPara(coordinate_src)
    lineNum = coordinate_src;
    para_list = [];
    lineCount = [];
    for k = 1:length(coordinate_src)
        % k th line st point
        % ath 为第th条线段的起点；bth为终点
        eval(['line',num2str(k),'=','lineNum(k,:)',';']);
        lineName = ['line',num2str(k)];
        tmp = convertCharsToStrings(lineName);
        lineCount = [lineCount; tmp];

        % 创建变量名
        paraTmp = [...
            convertCharsToStrings(sprintf('ax%d',k))...
            convertCharsToStrings(sprintf('ay%d',k))...
            convertCharsToStrings(sprintf('bx%d',k))...
            convertCharsToStrings(sprintf('by%d',k))...
            ];
        para_list = [para_list; paraTmp];
        
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
end