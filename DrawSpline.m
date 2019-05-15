% DrawSpline.m�ļ�
% [1]https://blog.csdn.net/Mr_Grit/article/details/45603627
function DrawSpline(n, k, P, NodeVector)
% B�����Ļ�ͼ����
% ��֪n+1�����ƶ���P(i), k��B������P��2*(n+1)�������ƶ�������, �ڵ�����NodeVector
plot(P(1, 1:n+1), P(2, 1:n+1),...
                    'o','LineWidth',1,...
                    'MarkerEdgeColor','k',...
                    'MarkerFaceColor','g',...
                    'MarkerSize',6);
line(P(1, 1:n+1), P(2, 1:n+1));
Nik = zeros(n+1, 1);
for u = 0 : 0.005 : 1-0.005
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
end