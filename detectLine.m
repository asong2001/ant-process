% detect line to fine the Coordinate 
% ��������ĻҶ�ͼ
function lines = detectLine(I1, peakNum, varargin)
    BW = I1;
    [H,T,R] = hough(BW);% �����ֵͼ��ı�׼����任��HΪ����任����
                                    % T,RΪ�������任�ĽǶȺͰ뾶ֵ

    figure;
    title('Hough Transform');
    imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');%hough�任��ͼ��
    xlabel('\theta'), ylabel('\rho');
    axis on,axis square,hold on;
    % pointNum = 20;  % ��ֵ������
    % P  = houghpeaks(H,pointNum);%��ȡ3����ֵ��
    P  = houghpeaks(H,peakNum,'threshold',ceil(0.3*max(H(:))));
    x = T(P(:,2));
    y = R(P(:,1));
    plot(x,y,'s','color','white');%�����ֵ��
    lines=houghlines(BW,T,R,P);%��ȡ�߶�
end
    % % ����
    % [col, row] = size(I);
    % LineStart = [];
    % LineEnd = [];

    % iter = 0;
    % % ����N�������ϵ�ֵ��0ʱ���ж��ʼ�������Ϊ�߶ε���ʼ��
    % for xx = 1:col
    %     for yy 1:row
            