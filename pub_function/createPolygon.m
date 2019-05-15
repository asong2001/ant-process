% 创建CST中的多边形
function [polygon,lineCount] = createPolygon(pLine, polygonName, curveName, para_list, lineCount)
    % lineCount = 'line'+number of this line
    % pLine is the objective of the creating line

    % With Polygon 
    %      .Reset 
    %      .Name "polygon1" 
    %      .Curve "curve1" 
    %      .Point "5", "2" 
    %      .LineTo "0", "2" 
    %      .LineTo "0", "-1" 
    %      .LineTo "1", "-1" 
    %      .LineTo "1", "-2" 
    %      .LineTo "3", "-2" 
    %      .LineTo "3", "-1" 
    %      .LineTo "5", "-1" 
    %      .LineTo "5", "2" 
    %      .Create 
    % End With 

    invoke(pLine, 'Reset');
    invoke(pLine, 'Name', polygonName);
    invoke(pLine, 'Curve', curveName);
    t = 0;
    for k = 1:length(lineCount)
        pre_para_list = para_list(k,:);% 当前考虑的线段
        if t == 0
            % 第一段
            invoke(pLine, 'Point', pre_para_list(1), pre_para_list(2));
            t = t + 1;
        else
            invoke(pLine, 'LineTo', pre_para_list(1), pre_para_list(2));
        end
    end
    invoke(pLine, 'Create');
    polygon = pLine;
end