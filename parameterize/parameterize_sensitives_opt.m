% sensitivities test
% ���Դ��ݱ���
clc;
clear;

%%ģ���ļ���ʼ��
cst = actxserver('CSTStudio.application');%��������CSTӦ�ÿؼ�
mws = invoke(cst, 'NewMWS');%�½�һ��MWS��Ŀ
app = invoke(mws, 'GetApplicationName');%��ȡ��ǰӦ������
ver = invoke(mws, 'GetApplicationVersion');%��ȡ��ǰӦ�ð汾��
%filename='E:\Matlab����CST��ģ�����Ż�\test1.cst';%���Խ��ļ�·�����ļ����ַֿ�д
%invoke(mws, 'OpenFile', filename);%��һ�����ڵ�CST�ļ�
invoke(mws, 'FileNew');%�½�һ��CST�ļ�
path_filename = 'D:\������\ͼ����\ant-process\parameterize\par.cst';
invoke(mws, 'SaveAs', path_filename, 'True');%True��ʾ���浽ĿǰΪֹ�Ľ��
% invoke(mws, 'DeleteResfults');%ɾ��֮ǰ�Ľ����ע�����н����������޸�ģ�ͻ���ֵ�����ʾ�Ƿ�ɾ��������������еĳ����ֹͣ����ȴ��ֶ��������ʹ֮��ʧ
%%ģ���ļ���ʼ������

%% ����ģ��
initialCST(mws);

%% ��CST�ڴ�������

load paraLine.mat;
src = zeros(length(paraLine), 6);
src(:, [1,2, 4,5]) = paraLine;
src = [src; src(1,:)];
lineNum = src;

[M,N] = size(src);
v = ones(1,N);

%% �Ż�����
% �Ż�����
StartFrequencyCMA = 2.4;% ���Ŀ��
delta = 10e6;
count = 0;
stepLength =2;

%% �������鲻ͬ״̬�µ�sensitive
% ���� sensitive Ҫ��S11�����
%% 

%% ��ţ�ٷ��������ŵ�
times = 35;% ���ű���
modalSig1 = zeros(1001,3);
modalSig2 = modalSig1;
modalSig3 = modalSig1;

while delta > 0.05 || count < 3
    try
        % ɾ������ʵ����
        invoke(mws, 'DeleteResults');
        % Solid.Delete "component1:solid1" ɾ������ģ��
        Solid = invoke(mws, 'Solid');
        invoke(Solid, "Delete", "component1:solid1");
        
        % Curve.DeleteCurveItem "curve1", "polygon1" 
        Curve = invoke(mws, 'Curve');
        invoke(Curve, 'DeleteCurveItem', "curve1", "polygon1"); 
    catch 
            disp('No model');
    end

    count  = count + 1;
    
    %% ���Ż�
    lineNumToMove = 21;% �ƶ���ֱ�߱��
    lineToMove = src(lineNumToMove,:);
    dim = 2;
    stepLength = stepLength + 2;
    % ���㷨����
    normalVector = lineNormalVector(lineToMove, dim);
    newLinek = moveLine(-normalVector, lineToMove, stepLength,dim);
    newSrc = updateMoveLine(src, newLinek, lineNumToMove, dim);
    %% ���Ż�����
    
    %% ����CST�Ĳ���
%     times = times + 1;
    tag = 1;
    scaled_src = scale(newSrc, times, tag);
    
    para_src = scaled_src;% ���ڴ���������ֵ
    color = 'Red';
    drawAntennaInMATLAB(newSrc, color);
    
    [point_para_list] = createCSTPara2(mws, scaled_src);
    %% CST���²������

    %% ��������
    builder = CST_MicrowaveStudio;
    Str_component = 'curve1';
    % lineCount = [];% ��¼������ֱ��
    curveName = 'curve1';
    % [polygon,lineCount] = createPolygon(pLine, polygonName, curveName, para_list, lineCount);
    [lineCount, endLine] = createLineCST(mws, point_para_list, curveName);
    %% �����������
    
    %% ������������
    CoverCurve(mws, endLine);
    %% �������ִ������
    
    %% ����solver
    % ����Ƶ�ʷ�ΧSolver.FrequencyRange "2", "3"
    solver = invoke(mws, 'Solver');
    startFreq = 2;% GHz
    endFreq = 3;
    invoke(solver,"FrequencyRange", num2str(startFreq),num2str(endFreq));
    
    % ��������ģ����
    NumberOfModesCMA = 3;
    startIntegralEq(mws, NumberOfModesCMA, StartFrequencyCMA);
    invoke(mws, 'Save');
    %% solver ������
    
    %% ���ݲɼ�
    exportpath = './result/';
    CstExportModalSignificanceTXT(mws, exportpath, NumberOfModesCMA);
    % һ���Ը���CMA ��������ȷ����modal��������ÿһ����һ��Mode
    [Frequency, ModalSignificance] = CstLoadModalSignificanceTXT(exportpath, NumberOfModesCMA);
    modalSig1(:,count) = ModalSignificance(:,1);
    modalSig2(:,count) = ModalSignificance(:,2);
    modalSig3(:,count) = ModalSignificance(:,3);
    %% ���ݲɼ�����
    
    %% ���ݷ���
    figure;
    for k = 1:NumberOfModesCMA
        plot(Frequency(:,k), ModalSignificance(:,k));
        hold on
    end
    hold off
    
    [row,col] = find(ModalSignificance == max(ModalSignificance));
    calculated_freq = Frequency([row,col]);
    calculated_freq = calculated_freq';
    dd = abs(calculated_freq - StartFrequencyCMA);
    delta = min(dd(1,:));
    disp(['Best freq at ', num2str(delta)]);
end
%% �Ż����̽���

