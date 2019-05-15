clc;
clear;

load createLineData.mat;
src = zeros(length(createLine), 6);
src(:, [1,2, 4,5]) = createLine;
lineNum = src;

%%ģ���ļ���ʼ��
cst = actxserver('CSTStudio.application');%��������CSTӦ�ÿؼ�
mws = invoke(cst, 'NewMWS');%�½�һ��MWS��Ŀ
app = invoke(mws, 'GetApplicationName');%��ȡ��ǰӦ������
ver = invoke(mws, 'GetApplicationVersion');%��ȡ��ǰӦ�ð汾��
%filename='E:\Matlab����CST��ģ�����Ż�\test1.cst';%���Խ��ļ�·�����ļ����ַֿ�д
%invoke(mws, 'OpenFile', filename);%��һ�����ڵ�CST�ļ�
invoke(mws, 'FileNew');%�½�һ��CST�ļ�
filename='./model.cst';%���Խ��ļ�·�����ļ����ַֿ�д
invoke(mws, 'SaveAs', filename, 'True');%True��ʾ���浽ĿǰΪֹ�Ľ��
% invoke(mws, 'DeleteResfults');%ɾ��֮ǰ�Ľ����ע�����н����������޸�ģ�ͻ���ֵ�����ʾ�Ƿ�ɾ��������������еĳ����ֹͣ����ȴ��ֶ��������ʹ֮��ʧ
%%ģ���ļ���ʼ������

for k = 1:length(src)
        % k th line st point
        % ath Ϊ��th���߶ε���㣻bthΪ�յ�
        eval(['line',num2str(k),'=','lineNum(k,:)',';']);
        % ax = src(k,1);
        % ay = src(k,2);
        % az = src(k,3);
        
        % bx = src(k,4);
        % by = src(k,5);
        % bz = src(k,6);

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
        pLine = invoke(mws, 'Line');
        builder = CST_MicrowaveStudio;
        lineName = ['line',num2str(k)];
        Str_component = ['curve', num2str(k)];
        eval(['ax',num2str(k)]) = 1;
        X1 = ['ax',num2str(k)];
        Y1 = ['ay',num2str(k)];
        X2 = ['bx',num2str(k)];
        Y2 = ['by',num2str(k)];
        invoke(pLine, 'Reset');
%         invoke(brick, 'Material', "PEC");
        invoke(pLine, 'Name',lineName);
        invoke(pLine, 'Curve', Str_component);
        invoke(pLine, 'Point', X1, Y1);
        invoke(pLine, 'LineTo', X2, Y2);
        % invoke(brick, 'Zrange', Z1, Z2);
        invoke(pLine, 'Create');
        release(pLine);
%         CST_MicrowaveStudio.addPolygonBlock(obj,points,height,name,component,material)
%         release(brick);
end

% invoke(brick, 'X1', num2str(lineNum(k,1)));% �м���Ϊ������
% invoke(brick, 'Y1', num2str(lineNum(k,2)));
% invoke(brick, 'X2', num2str(lineNum(k,4)));
% invoke(brick, 'Y2', num2str(lineNum(k,5)));