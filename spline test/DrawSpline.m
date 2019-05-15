% DrawSpline.m文件
% [1]https://blog.csdn.net/Mr_Grit/article/details/45603627
function opt_P = DrawSpline(n, k, P, NodeVector)
% B样条的绘图函数
% 已知n+1个控制顶点P(i), k次B样条，P是2*(n+1)矩阵存控制顶点坐标, 节点向量NodeVector
figure(1);
plot(P(1, 1:n+1), P(2, 1:n+1),...
    'o','LineWidth',1,...
    'MarkerEdgeColor','k',...
    'MarkerFaceColor','g',...
    'MarkerSize',6);

line(P(1, 1:n+1), P(2, 1:n+1));
Nik = zeros(n+1, 1);
ind = 0;
for u = 0 : 0.005 : 1-0.005
    figure(2);
    ind = ind + 1;

    for i = 0 : 1 : n
        Nik(i+1, 1) = BaseFunction(i, k , u, NodeVector);
    end
    p_u = P * Nik;
    if u == 0
        tempx = p_u(1,1);
        tempy = p_u(2,1);
        line([tempx p_u(1,1)], [tempy p_u(2,1)],...
            'Marker','.','LineStyle','-', 'Color',[.3 .6 .9], 'LineWidth',3);
    else
        line([tempx p_u(1,1)], [tempy p_u(2,1)],...
            'Marker','.','LineStyle','-', 'Color',[.3 .6 .9], 'LineWidth',3);
        tempx = p_u(1,1);
        tempy = p_u(2,1);
    end
    opt_P(ind,:) = [tempx tempy];
end
