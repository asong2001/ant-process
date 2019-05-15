% 测试传递变量
clc;
clear;

%%模型文件初始化
cst = actxserver('CSTStudio.application');%首先载入CST应用控件
mws = invoke(cst, 'NewMWS');%新建一个MWS项目
app = invoke(mws, 'GetApplicationName');%获取当前应用名称
ver = invoke(mws, 'GetApplicationVersion');%获取当前应用版本号
%filename='E:\Matlab控制CST建模仿真优化\test1.cst';%可以将文件路径和文件名字分开写
%invoke(mws, 'OpenFile', filename);%打开一个存在的CST文件
invoke(mws, 'FileNew');%新建一个CST文件
% filename = 'var.cst';
% path_filename = ['./', filename];
path_filename = 'D:\课题组\图像处理\ant-process\parameterize\par.cst';
invoke(mws, 'SaveAs', path_filename, 'True');%True表示保存到目前为止的结果
% invoke(mws, 'DeleteResfults');%删除之前的结果。注：在有结果的情况下修改模型会出现弹窗提示是否删除结果，这样运行的程序会停止，需等待手动点击弹窗使之消失
%%模型文件初始化结束

%% 建立模型
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

%% 在CST内创建参数

load paraLine.mat;
src = zeros(length(paraLine), 6);
src(:, [1,2, 4,5]) = paraLine;
src = [src; src(1,:)];
lineNum = src;

[M,N] = size(src);
v = ones(1,N);

StartFrequencyCMA = 2.4;% 设计目标
delta = 10e6;
times = 39;% 倍率

% while delta > 0.01
        try
                invoke(mws, 'DeleteResults');
                % Solid.Delete "component1:solid1" 删除已有模型
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
        
        para_src = scaled_src;% 用于创建变量的值
        figure(100);
        drawAntennaInMATLAB(para_src);
        
        [para_list,lineCount] = createCSTPara(mws,para_src);
        %% CST创建参数完成
        
        %% 创建曲线
        pLine = invoke(mws, 'Polygon');
        builder = CST_MicrowaveStudio;
        Str_component = 'curve1';
        % lineCount = [];% 记录产生的直线
        polygonName = 'polygon1';
        curveName = 'curve1';
        [polygon,lineCount] = createPolygon(pLine, polygonName, curveName, para_list, lineCount);
        %% 创建曲线完成
        
        %% 创建金属部分
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
        %% 金属部分创建完成
        
        %% 启动solver
        % 设置频率范围Solver.FrequencyRange "2", "3"
        solver = invoke(mws, 'Solver');
        startFreq = 2;% GHz
        endFreq = 3;
        invoke(solver,"FrequencyRange", num2str(startFreq),num2str(endFreq));
        
        % 启动特征模分析
        NumberOfModesCMA = 3;
        startIntegralEq(mws, NumberOfModesCMA, StartFrequencyCMA);
        invoke(mws, 'Save');
        %% solver 跑完了
        
        %% 数据采集
        exportpath = './result/';
        CstExportModalSignificanceTXT(mws, exportpath, NumberOfModesCMA);
        [Frequency, ModalSignificance] = CstLoadModalSignificanceTXT(exportpath, NumberOfModesCMA);
        %% 数据采集结束
        
        %% 数据分析
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
%% 数据分析
