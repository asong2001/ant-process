% 测试传递变量
clc;
clear;

load paraLine.mat;
src = zeros(length(paraLine), 6);
src(:, [1,2, 4,5]) = paraLine;
lineNum = src;

%%模型文件初始化
cst = actxserver('CSTStudio.application');%首先载入CST应用控件
mws = invoke(cst, 'NewMWS');%新建一个MWS项目
app = invoke(mws, 'GetApplicationName');%获取当前应用名称
ver = invoke(mws, 'GetApplicationVersion');%获取当前应用版本号
%filename='E:\Matlab控制CST建模仿真优化\test1.cst';%可以将文件路径和文件名字分开写
%invoke(mws, 'OpenFile', filename);%打开一个存在的CST文件
invoke(mws, 'FileNew');%新建一个CST文件
filename='./var.cst';%可以将文件路径和文件名字分开写
invoke(mws, 'SaveAs', filename, 'True');%True表示保存到目前为止的结果
% invoke(mws, 'DeleteResfults');%删除之前的结果。注：在有结果的情况下修改模型会出现弹窗提示是否删除结果，这样运行的程序会停止，需等待手动点击弹窗使之消失
%%模型文件初始化结束

%%全局单位初始化
units = invoke(mws, 'Units');
invoke(units, 'Geometry', 'mm');
invoke(units, 'Frequency', 'ghz');
invoke(units, 'Time', 'ns');
invoke(units, 'TemperatureUnit', 'kelvin');
release(units);
%%全局单位初始化结束

%%背景材料设置
background = invoke(mws, 'Background');
invoke(background, 'ResetBackground');
invoke(background, 'Type', 'Normal');
release(background);
%%背景材料设置结束

%%边界条件设置。
boundary = invoke(mws, 'Boundary');
invoke(boundary, 'Xmin', 'expanded open');%常用的值：”electric””magnetic””open””expanded open””periodic”"conducting wall"等
invoke(boundary, 'Xmax', 'expanded open');
invoke(boundary, 'Ymin', 'expanded open');
invoke(boundary, 'Ymax', 'expanded open');
invoke(boundary, 'Zmin', 'expanded open');
invoke(boundary, 'Zmax', 'expanded open');
invoke(boundary, 'Xsymmetry', 'none');%可以是”electric””magnetic””none”
invoke(boundary, 'Ysymmetry', 'none');
invoke(boundary, 'Zsymmetry', 'none');
invoke(boundary, 'ApplyInAllDirections', 'True');
release(boundary);
%%边界条件设置结束

%%使Bounding Box显示
plot = invoke(mws, 'Plot');
invoke(plot, 'DrawBox', 'True');
release(plot);
%%使Bounding Box显示结束

%% 建立模型
% 设置建立的模型的样式
pLine = invoke(mws, 'Line');
builder = CST_MicrowaveStudio;
% Str_component = ['curve', num2str(k)];
Str_component = 'curve1';
lineCount = [];% 记录产生的直线

for k = 1:length(src)
    % k th line st point
    % ath 为第th条线段的起点；bth为终点
    eval(['line',num2str(k),'=','lineNum(k,:)',';']);
    lineName = ['line',num2str(k)];
    tmp = convertCharsToStrings(lineName);
    lineCount = [lineCount; tmp];

    % 创建变量名
    eval(['ax',num2str(k)]) = num2str(0);
    eval(['ay',num2str(k)]) = num2str(0);
    eval(['bx',num2str(k)]) = num2str(3);
    eval(['by',num2str(k)]) = num2str(3);
    
    % 变量赋值
    X1 = ['ax',num2str(k)];
    Y1 = ['ay',num2str(k)];
    X2 = ['bx',num2str(k)];
    Y2 = ['by',num2str(k)];
    
    l = lineNum(k,:);
    ax = l(1);
    ay = l(2);
    bx = l(4);
    by = l(5);
    
    invoke(mws, 'StoreParameter', X1, ax);
    invoke(mws, 'StoreParameter', Y1, ay);
    invoke(mws, 'StoreParameter', X2, bx);
    invoke(mws, 'StoreParameter', Y2, by);
                
    invoke(pLine, 'Reset');
%         invoke(brick, 'Material', "PEC");
    invoke(pLine, 'Name',lineName);
    invoke(pLine, 'Curve', Str_component);
    invoke(pLine, 'X1', num2str(ax));
    invoke(pLine, 'Y1', num2str(ay));
    invoke(pLine, 'X2', num2str(bx));
    invoke(pLine, 'Y2', num2str(by));
    % invoke(brick, 'Zrange', Z1, Z2);
    invoke(pLine, 'Create');
end
% release(pLine);

%% 覆盖多边形金属面
Curve = {Str_component,':', lineCount(end)};
ExtrudeCurve(mws, Curve);
