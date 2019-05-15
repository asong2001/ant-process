% detect line to fine the Coordinate 
% 处理输入的灰度图
function lines = detectLine(I1, peakNum, varargin)
    BW = I1;
    [H,T,R] = hough(BW);% 计算二值图像的标准霍夫变换，H为霍夫变换矩阵
                                    % T,R为计算霍夫变换的角度和半径值

    figure;
    title('Hough Transform');
    imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');%hough变换的图像
    xlabel('\theta'), ylabel('\rho');
    axis on,axis square,hold on;
    % pointNum = 20;  % 极值点数量
    % P  = houghpeaks(H,pointNum);%提取3个极值点
    P  = houghpeaks(H,peakNum,'threshold',ceil(0.3*max(H(:))));
    x = T(P(:,2));
    y = R(P(:,1));
    plot(x,y,'s','color','white');%标出极值点
    lines=houghlines(BW,T,R,P);%提取线段
end
    % % 横向
    % [col, row] = size(I);
    % LineStart = [];
    % LineEnd = [];

    % iter = 0;
    % % 连续N个坐标上的值非0时，判断最开始的坐标点为线段的起始点
    % for xx = 1:col
    %     for yy 1:row
            