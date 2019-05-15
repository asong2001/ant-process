% Éú³ÉÏß¶Î
function model_line(brick,position,lineNum)
    % With Line
    %      .Reset 
    %      .Name "line1" 
    %      .Curve "curve1" 
    %      .X1 "150"           
    %      .Y1 "-50" 
    %      .X2 "-0" 
    %      .Y2 "-50" 
    %      .Create
    % End With
    X1 = position(1);
    Y1 = position(2);
    X2 = position(3);
    Y2 = position(4);
    Z1 = 0;
    Z2 = 0;
    
    Str_name = ['line', num2str(lineNum)];
    Str_component = ['curve', num2str(1)];

    invoke(brick, 'Reset');
    invoke(brick, 'Name',Str_name);
    invoke(brick, 'Component', Str_component);
    invoke(brick, 'Point', X1, Y1);
    invoke(brick, 'LineTo', X2, Y2);
%     invoke(brick, 'Zrange', Z1, Z2);
    invoke(brick, 'Create');
    release(brick);


    %{
    invoke(brick, 'Reset');
    invoke(brick, 'Name',Str_name);
    invoke(brick, 'Component', Str_component);
    invoke(brick, 'X1', num2str(X1));
    invoke(brick, 'Y1', num2str(Y1));
    invoke(brick, 'X2', num2str(X2));
    invoke(brick, 'Y2', num2str(Y2));
    invoke(brick, 'Create');
    release(brick);

    With Polygon 
     .Reset 
     .Name "polygon1" 
     .Curve "curve1" 
     .Point "-23.8", "10.4" 
     .LineTo "-26.4", "-2.2" 
     .LineTo "-13.8", "5" 
     .LineTo "-23.8", "10" 
     .Create 
    End With 

    %}


end