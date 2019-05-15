% 重新写一遍合并直线，感觉逻辑不对
% spline test
clc;
clear;
close all;

% 输入2.png的坐标
load coordinate_of_2jpg.mat
srcX = position(1:end,1);
scrY = position(1:end,2);

%% [1]https://blog.csdn.net/Mr_Grit/article/details/45603627 样条逼近
% 控制定点P
P = [srcX scrY];
flag = 1;

opt_P = spline_approach(P, flag);

%% 重合线段合并
[lenP,~] = size(opt_P);
createLine = [];% 新直线数组
numOfLine = 0; % 线段的数量
for k = 2:lenP-1
    prePoint = opt_P(k,:);
    if k == 2
        % 还没有直线的情况下，初始化
        preLine = [opt_P(1,:) opt_P(2,:)];
        createLine(1,:) = preLine;
        numOfLine = numOfLine + 1;
        lastStartPoint = createLine(numOfLine,1:2);
        lastEndPoint = createLine(numOfLine,3:4);
    else
        % 已经产生了一条直线
        lastLine = createLine(numOfLine,:);
        lastStartPoint = lastLine(:,1:2);
        lastEndPoint = lastLine(:,3:4);
        preLine = [lastEndPoint prePoint];
        isOverLap = line_overlap(lastLine,preLine);

        if isOverLap == true
            % 直线重合，变更终点为新的直线的重点，起点不变
            createLine(numOfLine,1:2) = lastStartPoint;
            createLine(numOfLine,3:4) = prePoint;
            disp('Extend line');
        else
            numOfLine = numOfLine + 1;
            createLine = [createLine; preLine];
            disp('Add new line');
        end
    end
end

%% 数组重构
createLine = [createLine;createLine(end-1,3:4) createLine(1,1:2)];
figure(2);
for k = 1:numOfLine+1
    [x,y] = transformCoordinate(createLine(k,:));
    line(x,y);
    hold on 
    plot(x,y,'ro');
end
