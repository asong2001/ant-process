% 创建CST 的多边形
function [lineCount, endLine] = createLineCST(mws, point_para_list, curveName)
% With Line
%      .Reset 
%      .Name "line1" 
%      .Curve "curve1" 
%      .X1 "0" 
%      .Y1 "0" 
%      .X2 "7" 
%      .Y2 "0" 
%      .Create
% End With    

% pLine is the object
    N = length(point_para_list);
    lineCount = 0;
    for k = 1:N-1   
            lineCount = lineCount + 1;
            pLine = invoke(mws, 'Line');
            invoke(pLine, 'Reset');
            invoke(pLine, 'Name', ['line',num2str(k)]);
            invoke(pLine, 'Curve', curveName);
            invoke(pLine, 'X1', point_para_list(k,1));
            invoke(pLine, 'Y1', point_para_list(k,2));
            invoke(pLine, 'X2', point_para_list(k+1,1));
            invoke(pLine, 'Y2', point_para_list(k+1,2));
            invoke(pLine,'Create');
    end
    endLine = ['line', num2str(N-1)];
