% function create line in CST
function create_line(lineName, start_point, end_point)
    % With Line
    %     .Reset 
    %     .Name "line2" 
    %     .Curve "curve1" 
    %     .X1 "0" 
    %     .Y1 "-0" 
    %     .X2 "0" 
    %     .Y2 "b" 
    %     .Create
    % End With 
    X1 = start_point(1);
    Y1 = start_point(2);
    
    X2 = end_point(1);
    Y2 = end_point(2);
    
    invoke(brick, 'Reset');
    invoke(brick, 'Name',lineName);
    invoke(brick, 'Component', Str_component);
    invoke(brick, 'Point', X1, Y1);
    invoke(brick, 'LineTo', X2, Y2);
    % invoke(brick, 'Zrange', Z1, Z2);
    invoke(brick, 'Create');
    release(brick);
end