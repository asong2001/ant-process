%%���͵�VB����ת��ΪCST����������ʾ[1]:
% With Brick                                    brick = invoke(mws, 'Brick')
%     .Reset                                    invoke(brick, 'Reset');
%     .Name ("brick1")                          invoke(brick, 'Name', "brick1");
%     .Component ("component1")                 invoke(brick, 'Component', "component1");
%     .Material ("PEC")               ==��      invoke(brick, 'Material', "PEC");
%     .Xrange (0, 2)                            invoke(brick, 'Xrange', 0, 2);
%     .Yrange (0, 3)                            invoke(brick, 'Yrange', 0, 3);
%     .Zrange (0, "a+3")                        invoke(brick, 'Zrange', '0', num2str(a+3));
%     .Create                                   invoke(brick, 'Create');
% End With                                      release(brick);
%����˼·�����ҳ�mws����Ҫ�����Ķ���Ȼ��������в������и�ֵ����ִ�����Ȼ���ͷŶ���

% ��ģ

function modelling(position)
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
    invoke(mws, 'DeleteResfults');%ɾ��֮ǰ�Ľ����ע�����н����������޸�ģ�ͻ���ֵ�����ʾ�Ƿ�ɾ��������������еĳ����ֹͣ����ȴ��ֶ��������ʹ֮��ʧ
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

    %%��ģ��ʼ
    %%����Brick����ʼ
    brick = invoke(mws, 'Brick');

    %% postion control
    % position = [150 50 -0 -50];
%     obj = brick;
%     points = position;
%     height = 1;
%     name = 'po1';
%     component = 'Patch';
%     material = 'PEC';

    builder = CST_MicrowaveStudio;
    for k = 1:length(position)
        lineNum = k;
        model_line(brick,position,lineNum);
    end
%     CST_MicrowaveStudio.addPolygonBlock(obj,points,height,name,component,material)
    release(brick);
    
% With Line
%      .Reset 
%      .Name "line1" 
%      .Curve "curve1" 
%      .X1 "150"           
%      .Y1 "-50" 
%      .X2 "-0" 
%      .Y2 "-50" 
%      .Create
% End With

%     lineNum = 1;
%     invoke(brick, 'Reset');
%     invoke(brick, 'Name', ['line', num2str(lineNum)]);
%     invoke(brick, 'Curve', ['curve', num2str(lineNum)]);
%     invoke(brick, 'X1', '150');
%     invoke(brick, 'Y1', '50');
%     invoke(brick, 'X2', '-0');
%     invoke(brick, 'Y2', '-50');
%     invoke(brick, 'Create');
%     release(brick);

end
