function normalVector = lineNormalVector(linek, dim)
% input line's start point and end point
% 返回直线的法向量
if dim == 2
        % 二维情况
        start_p = linek(1:2);
        end_p = linek(4:5);
        % 斜率
        tmp = end_p - start_p;
        
        if tmp(1) == 0
                disp('line normal to x-axis');
                normalVector = [1 0];

        elseif tmp(2) == 0
                normalVector = [0 1];
                
        else
                k = tmp(2) / tmp(1);
                normal_k = -1/k;
                y = normal_k * 1;
                
                normalVector = [1 y] / sqrt(y^2 + 1);
        end
end

if normalVector(1) < 0 
        normalVector = -normalVector;
end