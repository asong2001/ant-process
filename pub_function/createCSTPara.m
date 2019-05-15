% 创建CST中的变量
function [para_list,lineCount] = createCSTPara(mws,coordinate_src)
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
%         eval(['ax',num2str(k)]) = num2str(0);
%         eval(['ay',num2str(k)]) = num2str(0);
%         eval(['bx',num2str(k)]) = num2str(3);
%         eval(['by',num2str(k)]) = num2str(3);
        paraTmp = [...
            convertCharsToStrings(sprintf('ax%d',k))...
            convertCharsToStrings(sprintf('ay%d',k))...
            convertCharsToStrings(sprintf('bx%d',k))...
            convertCharsToStrings(sprintf('by%d',k))...
            ];
        para_list = [para_list; paraTmp];
        
        % 变量名赋值
        X1 = ['ax',num2str(k)];
        Y1 = ['ay',num2str(k)];
        X2 = ['bx',num2str(k)];
        Y2 = ['by',num2str(k)];
        
        % 变量值赋值
        l = lineNum(k,:);
        ax = l(1);
        ay = l(2);
        bx = l(4);
        by = l(5);

        invoke(mws, 'StoreParameter', X1, ax);% 变量名，变量值
        invoke(mws, 'StoreParameter', Y1, ay);
        invoke(mws, 'StoreParameter', X2, bx);
        invoke(mws, 'StoreParameter', Y2, by);
    end
end