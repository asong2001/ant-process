% ����дһ��ϲ�ֱ�ߣ��о��߼�����
% spline test
clc;
clear;
close all;

% ����2.png������
load coordinate_of_2jpg.mat
srcX = position(1:end,1);
scrY = position(1:end,2);

%% [1]https://blog.csdn.net/Mr_Grit/article/details/45603627 �����ƽ�
% ���ƶ���P
P = [srcX scrY];
flag = 1;

opt_P = spline_approach(P, flag);

%% �غ��߶κϲ�
[lenP,~] = size(opt_P);
createLine = [];% ��ֱ������
numOfLine = 0; % �߶ε�����
for k = 2:lenP-1
    prePoint = opt_P(k,:);
    if k == 2
        % ��û��ֱ�ߵ�����£���ʼ��
        preLine = [opt_P(1,:) opt_P(2,:)];
        createLine(1,:) = preLine;
        numOfLine = numOfLine + 1;
        lastStartPoint = createLine(numOfLine,1:2);
        lastEndPoint = createLine(numOfLine,3:4);
    else
        % �Ѿ�������һ��ֱ��
        lastLine = createLine(numOfLine,:);
        lastStartPoint = lastLine(:,1:2);
        lastEndPoint = lastLine(:,3:4);
        preLine = [lastEndPoint prePoint];
        isOverLap = line_overlap(lastLine,preLine);

        if isOverLap == true
            % ֱ���غϣ�����յ�Ϊ�µ�ֱ�ߵ��ص㣬��㲻��
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

%% �����ع�
createLine = [createLine;createLine(end-1,3:4) createLine(1,1:2)];
figure(2);
for k = 1:numOfLine+1
    [x,y] = transformCoordinate(createLine(k,:));
    line(x,y);
    hold on 
    plot(x,y,'ro');
end
