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
% filename = 'var.cst';
% path_filename = ['./', filename];
path_filename = 'D:\������\ͼ����\ant-process\parameterize\par.cst';
invoke(mws, 'SaveAs', path_filename, 'True');%True��ʾ���浽ĿǰΪֹ�Ľ��
% invoke(mws, 'DeleteResfults');%ɾ��֮ǰ�Ľ����ע�����н����������޸�ģ�ͻ���ֵ�����ʾ�Ƿ�ɾ��������������еĳ����ֹͣ����ȴ��ֶ��������ʹ֮��ʧ
%%ģ���ļ���ʼ������

%% ����ģ��
initialCST(mws);
% -----------VBA---------------- %
% With Polygon
%      .Reset
%      .Name "polygon1"
%      .Curve "curve1"
%      .Point "5", "2"
%      .LineTo "0", "2"
%      .LineTo "0", "-1"
%      .LineTo "1", "-1"
%      .LineTo "1", "-2"
%      .LineTo "3", "-2"
%      .LineTo "3", "-1"
%      .LineTo "5", "-1"
%      .LineTo "5", "2"
%      .Create
% End With
% -----------VBA---------------- %

%% ��CST�ڴ�������

load paraLine.mat;
src = zeros(length(paraLine), 6);
src(:, [1,2, 4,5]) = paraLine;
src = [src; src(1,:)];
lineNum = src;

[M,N] = size(src);
v = ones(1,N);

StartFrequencyCMA = 2.4;% ���Ŀ��
delta = 10e6;
times = 39;% ����

% while delta > 0.01
        try
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
        
        times = times + 1;
        tag = 1;
        scaled_src = scale(src, times, tag);
        
        para_src = scaled_src;% ���ڴ���������ֵ
        figure(100);
        drawAntennaInMATLAB(para_src);
        
        [para_list,lineCount] = createCSTPara(mws,para_src);
        %% CST�����������
        
        %% ��������
        pLine = invoke(mws, 'Polygon');
        builder = CST_MicrowaveStudio;
        Str_component = 'curve1';
        % lineCount = [];% ��¼������ֱ��
        polygonName = 'polygon1';
        curveName = 'curve1';
        [polygon,lineCount] = createPolygon(pLine, polygonName, curveName, para_list, lineCount);
        %% �����������
        
        %% ������������
        % -----------VBA---------------- %
        % With ExtrudeCurve
        %      .Reset
        %      .Name "solid1"
        %      .Component "component1"
        %      .Material "PEC"
        %      .Thickness "0.0"
        %      .Twistangle "0.0"
        %      .Taperangle "0.0"
        %      .DeleteProfile "True"
        %      .Curve "curve1:polygon1"
        %      .Create
        % End With
        % -----------VBA---------------- %
        Curve = sprintf('%s%s%s',Str_component,':', polygonName);
        ExtrudeCurve(mws, Curve);
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
        [Frequency, ModalSignificance] = CstLoadModalSignificanceTXT(exportpath, NumberOfModesCMA);
        %% ���ݲɼ�����
        
        %% ���ݷ���
        figure(101);
        for k = 1:NumberOfModesCMA
                plot(Frequency(:,k), ModalSignificance(:,k));
                hold on
        end
        hold off
        
        [row,col] = find(ModalSignificance == max(ModalSignificance));
        calculated_freq = Frequency([row,col]);
        calculated_freq = calculated_freq';
        dd = abs(calculated_freq - StartFrequencyCMA);
        delta = min(dd(1,:))
        disp(['Best freq at ', num2str(delta)]);
        
%         Tree = '1D Results\Characteristic Mode Analysis';
%         SelectTreeItem = invoke(mws,'SelectTreeItem',Tree);
%         invoke(SelectTreeItem, 'Delete', convertCharsToStrings(Tree));
% end
%% ���ݷ���
