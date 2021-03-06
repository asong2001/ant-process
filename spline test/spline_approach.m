% spline approach
function opt_P = spline_approach(P, flag)

% [1]https://blog.csdn.net/Mr_Grit/article/details/45603627
% 控制定点P
[row, col] = size(P);
if row > col
    P = P';
end

% 测试数据
% P = [9.036145, 21.084337, 37.607573, 51.893287, 61.187608;...
%     51.779661, 70.084746, 50.254237, 69.745763, 49.576271];
% n = 坐标点数量-1
n = length(P) - 1;
k = 3;

switch flag
    case 1
        NodeVector = linspace(0, 1, n+k+2); % 均匀B样条的节点矢量
        % 绘制样条曲线
        plot(P(1, 1:n+1), P(2, 1:n+1),...
            'o','LineWidth',1,...
            'MarkerEdgeColor','k',...
            'MarkerFaceColor','g',...
            'MarkerSize',6);
        line(P(1, 1:n+1), P(2, 1:n+1));
        Nik = zeros(n+1, 1);
        ind = 0;
        for u = k/(n+k+1) : 0.001 : (n+1)/(n+k+1)
            ind = ind + 1;
            % for u = 0 : 0.005 : 1
            for i = 0 : 1 : n
                Nik(i+1, 1) = BaseFunction(i, k , u, NodeVector);
            end
            p_u = P * Nik;
%             figure;
%             line(p_u(1,1), p_u(2,1), 'Marker','.','LineStyle','-', 'Color',[.3 .6 .9]);
            opt_P(ind,:) = p_u';
        end

        
    case 2
        NodeVector = U_quasi_uniform(n, k); % 准均匀B样条的节点矢量
%         opt_P = DrawSpline(n, k, P, NodeVector);
        
    case 3
        NodeVector = U_piecewise_Bezier(n, k);  % 分段Bezier曲线的节点矢量
%         opt_P = DrawSpline(n, k, P, NodeVector);
        
    otherwise
        fprintf('error!\n');
end

