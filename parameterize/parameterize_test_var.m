% ���Դ��ݱ���
clc;
clear;

load paraLine.mat;
src = zeros(length(paraLine), 6);
src(:, [1,2, 4,5]) = paraLine;
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
% ���ý�����ģ�͵���ʽ
pLine = invoke(mws, 'Line');
builder = CST_MicrowaveStudio;
% Str_component = ['curve', num2str(k)];
Str_component = 'curve1';
lineCount = [];% ��¼������ֱ��

for k = 1:length(src)
    % k th line st point
    % ath Ϊ��th���߶ε���㣻bthΪ�յ�
    eval(['line',num2str(k),'=','lineNum(k,:)',';']);
    lineName = ['line',num2str(k)];
    tmp = convertCharsToStrings(lineName);
    lineCount = [lineCount; tmp];

    % ����������
    eval(['ax',num2str(k)]) = num2str(0);
    eval(['ay',num2str(k)]) = num2str(0);
    eval(['bx',num2str(k)]) = num2str(3);
    eval(['by',num2str(k)]) = num2str(3);
    
    % ������ֵ
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

%% ���Ƕ���ν�����
Curve = {Str_component,':', lineCount(end)};
ExtrudeCurve(mws, Curve);
