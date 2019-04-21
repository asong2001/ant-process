% ���Դ��ݱ���
clc;
clear;

load paraLine.mat;
src = zeros(length(paraLine), 6);
src(:, [1,2, 4,5]) = paraLine;
src = [src; src(1,:)];
lineNum = src;

%%ģ���ļ���ʼ��
cst = actxserver('CSTStudio.application');%��������CSTӦ�ÿؼ�
mws = invoke(cst, 'NewMWS');%�½�һ��MWS��Ŀ
app = invoke(mws, 'GetApplicationName');%��ȡ��ǰӦ������
ver = invoke(mws, 'GetApplicationVersion');%��ȡ��ǰӦ�ð汾��
%filename='E:\Matlab����CST��ģ�����Ż�\test1.cst';%���Խ��ļ�·�����ļ����ַֿ�д
%invoke(mws, 'OpenFile', filename);%��һ�����ڵ�CST�ļ�
invoke(mws, 'FileNew');%�½�һ��CST�ļ�
filename='./var.cst';%���Խ��ļ�·�����ļ����ַֿ�д
invoke(mws, 'SaveAs', filename, 'True');%True��ʾ���浽ĿǰΪֹ�Ľ��
% invoke(mws, 'DeleteResfults');%ɾ��֮ǰ�Ľ����ע�����н����������޸�ģ�ͻ���ֵ�����ʾ�Ƿ�ɾ��������������еĳ����ֹͣ����ȴ��ֶ��������ʹ֮��ʧ
%%ģ���ļ���ʼ������

%%ȫ�ֵ�λ��ʼ��
units = invoke(mws, 'Units');
invoke(units, 'Geometry', 'mm');
invoke(units, 'Frequency', 'ghz');
invoke(units, 'Time', 'ns');
invoke(units, 'TemperatureUnit', 'kelvin');
release(units);
%%ȫ�ֵ�λ��ʼ������

%%������������
background = invoke(mws, 'Background');
invoke(background, 'ResetBackground');
invoke(background, 'Type', 'Normal');
release(background);
%%�����������ý���

%%�߽��������á�
boundary = invoke(mws, 'Boundary');
invoke(boundary, 'Xmin', 'expanded open');%���õ�ֵ����electric����magnetic����open����expanded open����periodic��"conducting wall"��
invoke(boundary, 'Xmax', 'expanded open');
invoke(boundary, 'Ymin', 'expanded open');
invoke(boundary, 'Ymax', 'expanded open');
invoke(boundary, 'Zmin', 'expanded open');
invoke(boundary, 'Zmax', 'expanded open');
invoke(boundary, 'Xsymmetry', 'none');%�����ǡ�electric����magnetic����none��
invoke(boundary, 'Ysymmetry', 'none');
invoke(boundary, 'Zsymmetry', 'none');
invoke(boundary, 'ApplyInAllDirections', 'True');
release(boundary);
%%�߽��������ý���

%%ʹBounding Box��ʾ
plot = invoke(mws, 'Plot');
invoke(plot, 'DrawBox', 'True');
release(plot);
%%ʹBounding Box��ʾ����

%% ����ģ��
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

%% ��CST�ڴ�������
[para_list,lineCount] = createCSTPara(mws,src);
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
%% �������ִ������