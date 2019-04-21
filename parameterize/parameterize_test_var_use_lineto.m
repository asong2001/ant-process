% 测试传递变量
clc;
clear;

load paraLine.mat;
src = zeros(length(paraLine), 6);
src(:, [1,2, 4,5]) = paraLine;
src = [src; src(1,:)];
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
% -----------Common---------------- %
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
% -----------Common---------------- %

%% 在CST内创建参数
[para_list,lineCount] = createCSTPara(mws,src);
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
Curve = sprintf('%s%s%s',Str_component,':', polygonName);
ExtrudeCurve(mws, Curve);
%% 金属部分创建完成