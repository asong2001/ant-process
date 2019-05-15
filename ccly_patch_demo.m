%ccly_patch_antenna
%%MATLAB����CST��˼�������CST�Ľ�ģ����������VB�����Ҫ��ʹ��MATLAB������CST����Ҫ��Ӧ��֮���ͨ�Žӿ���Ϊһ�������ܽ���MATLAB��CST֮�䣬COM������������������顣
%%����CST�����еİ����ļ�����VB���Ե�ʹ�÷ǳ���ϸ������������Ҫ���ľ��ǽ�����������á�ע�������������ֶ�����CST��VB�������ڰ����ļ������ҵ���Ӧ����
%%��VB����ת��Ϊ��MATLAB���ܹ����еĴ�����MATLAB�Զ�����CST���н�ģ����Ĺؼ�
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

%%�ο����ף�
%%[1]CST. "Application Note - Calling CST Studio from Matlab"

%%��Ƭ���߽�ģ��������,��λ��mm
a=38.6;%��Ƭ��
b=38;%��Ƭ��
w=1.46;%���߿�100ŷķ
l=40;%���߳�
lx=100;%���峤
ly=100;%�����
ts=2;%�����
tm=0.035;%�������
Frq=[2,2.7];%����Ƶ��
%%��ģ�����������ý���

%%ģ���ļ���ʼ��
cst = actxserver('CSTStudio.application');%��������CSTӦ�ÿؼ�
mws = invoke(cst, 'NewMWS');%�½�һ��MWS��Ŀ
app = invoke(mws, 'GetApplicationName');%��ȡ��ǰӦ������
ver = invoke(mws, 'GetApplicationVersion');%��ȡ��ǰӦ�ð汾��
%filename='E:\Matlab����CST��ģ�����Ż�\test1.cst';%���Խ��ļ�·�����ļ����ַֿ�д
%invoke(mws, 'OpenFile', filename);%��һ�����ڵ�CST�ļ�
invoke(mws, 'FileNew');%�½�һ��CST�ļ�
filename='./test.cst';%���Խ��ļ�·�����ļ����ַֿ�д
invoke(mws, 'SaveAs', filename, 'True');%True��ʾ���浽ĿǰΪֹ�Ľ��
invoke(mws, 'DeleteResults');%ɾ��֮ǰ�Ľ����ע�����н����������޸�ģ�ͻ���ֵ�����ʾ�Ƿ�ɾ��������������еĳ����ֹͣ����ȴ��ֶ��������ʹ֮��ʧ
%%ģ���ļ���ʼ������

%%ȫ�ֵ�λ��ʼ��
units = invoke(mws, 'Units');
invoke(units, 'Geometry', 'mm');
invoke(units, 'Frequency', 'ghz');
invoke(units, 'Time', 'ns');
invoke(units, 'TemperatureUnit', 'kelvin');
release(units);
%%ȫ�ֵ�λ��ʼ������

%%����Ƶ������
solver = invoke(mws, 'Solver');
invoke(solver, 'FrequencyRange', Frq(1), Frq(2));%����ĺ���ֵ���������ȫ�ֵ�λ������
release(solver);
%%����Ƶ�����ý���

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

%%�½�������ʲ���
material = invoke(mws, 'Material');
material1 = 'material265';
er1 = 2.65;
invoke(material, 'Reset');
invoke(material, 'Name', material1);
invoke(material, 'FrqType', 'all');
invoke(material, 'Type', 'Normal');
invoke(material, 'Epsilon', er1);
invoke(material, 'Create');
release(material);
%%�½�������ʲ��Ͻ���

%%ʹBounding Box��ʾ
plot = invoke(mws, 'Plot');
invoke(plot, 'DrawBox', 'True');
release(plot);
%%ʹBounding Box��ʾ����

%%��ģ��ʼ
%%����Brick����ʼ
brick = invoke(mws, 'Brick');

Str_Name='patch';
Str_Component='Patch';
Str_Material='PEC';
x=[-a/2,a/2];
y=[-b/2,b/2];
z=[0,tm]; 
%������һ������д�ɺ���
invoke(brick, 'Reset');
invoke(brick, 'Name', Str_Name);
invoke(brick, 'Component', Str_Component);
invoke(brick, 'Material', Str_Material);
invoke(brick, 'Xrange', x(1), x(2));
invoke(brick, 'Yrange', y(1), y(2));
invoke(brick, 'Zrange', z(1), z(2));
invoke(brick, 'Create');
%������һ������д�ɺ���

Str_Name='line1';
Str_Component='Feed';
Str_Material='PEC';
x=[-lx/2,-a/2];
y=[-w/2,w/2];
z=[0,tm]; 
invoke(brick, 'Reset');
invoke(brick, 'Name', Str_Name);
invoke(brick, 'Component', Str_Component);
invoke(brick, 'Material', Str_Material);
invoke(brick, 'Xrange', x(1), x(2));
invoke(brick, 'Yrange', y(1), y(2));
invoke(brick, 'Zrange', z(1), z(2));
invoke(brick, 'Create');

Str_Name='line2';
Str_Component='Feed';
Str_Material='PEC';
x=[a/2,lx/2];
y=[-w/2,w/2];
z=[0,tm]; 
invoke(brick, 'Reset');
invoke(brick, 'Name', Str_Name);
invoke(brick, 'Component', Str_Component);
invoke(brick, 'Material', Str_Material);
invoke(brick, 'Xrange', x(1), x(2));
invoke(brick, 'Yrange', y(1), y(2));
invoke(brick, 'Zrange', z(1), z(2));
invoke(brick, 'Create');

Str_Name='bottom';
Str_Component='Bottom';
Str_Material='PEC';
x=[-lx/2,lx/2];
y=[-ly/2,ly/2];
z=[-ts-tm,-ts]; 
invoke(brick, 'Reset');
invoke(brick, 'Name', Str_Name);
invoke(brick, 'Component', Str_Component);
invoke(brick, 'Material', Str_Material);
invoke(brick, 'Xrange', x(1), x(2));
invoke(brick, 'Yrange', y(1), y(2));
invoke(brick, 'Zrange', z(1), z(2));
invoke(brick, 'Create');

Str_Name='sub';
Str_Component='Sub';
Str_Material=material1;
x=[-lx/2,lx/2];
y=[-ly/2,ly/2];
z=[-ts,0]; 
invoke(brick, 'Reset');
invoke(brick, 'Name', Str_Name);
invoke(brick, 'Component', Str_Component);
invoke(brick, 'Material', Str_Material);
invoke(brick, 'Xrange', x(1), x(2));
invoke(brick, 'Yrange', y(1), y(2));
invoke(brick, 'Zrange', z(1), z(2));
invoke(brick, 'Create');
%%��ģ����

%%�˿�����
%�˿�1
pick = invoke(mws, 'Pick');
invoke(pick, 'PickFaceFromId','Feed:line1', '4' );
port = invoke(mws, 'Port');
invoke(port, 'Reset');
invoke(port, 'PortNumber', '1');
invoke(port, 'Label', '');
invoke(port, 'NumberOfModes', '1');
invoke(port, 'AdjustPolarization', 'False');
invoke(port, 'PolarizationAngle', '0.0');
invoke(port, 'ReferencePlaneDistance', '0');
invoke(port, 'TextSize', '50');
invoke(port, 'TextMaxLimit', '0');
invoke(port, 'Coordinates', 'Picks');
invoke(port, 'Orientation', 'positive');
invoke(port, 'PortOnBound', 'False');
invoke(port, 'ClipPickedPortToBound', 'False');
invoke(port, 'Xrange', -lx/2, -lx/2);
invoke(port, 'Yrange', -w/2, w/2);
invoke(port, 'Zrange', 0, tm);
invoke(port, 'XrangeAdd', '0.0', '0.0');
invoke(port, 'YrangeAdd', 3*ts, 3*ts);
invoke(port, 'ZrangeAdd', ts, 3*ts);
invoke(port, 'SingleEnded', 'False');
invoke(port, 'Create');
%�˿�2
pick = invoke(mws, 'Pick');
invoke(pick, 'PickFaceFromId','Feed:line2', '6' );
port = invoke(mws, 'Port');
invoke(port, 'Reset');
invoke(port, 'PortNumber', '2');
invoke(port, 'Label', '');
invoke(port, 'NumberOfModes', '1');
invoke(port, 'AdjustPolarization', 'False');
invoke(port, 'PolarizationAngle', '0.0');
invoke(port, 'ReferencePlaneDistance', '0');
invoke(port, 'TextSize', '50');
invoke(port, 'TextMaxLimit', '0');
invoke(port, 'Coordinates', 'Picks');
invoke(port, 'Orientation', 'positive');
invoke(port, 'PortOnBound', 'False');
invoke(port, 'ClipPickedPortToBound', 'False');
invoke(port, 'Xrange', lx/2, lx/2);
invoke(port, 'Yrange', -w/2, w/2);
invoke(port, 'Zrange', 0, tm);
invoke(port, 'XrangeAdd', '0.0', '0.0');
invoke(port, 'YrangeAdd', 3*ts, 3*ts);
invoke(port, 'ZrangeAdd', ts, 3*ts);
invoke(port, 'SingleEnded', 'False');
invoke(port, 'Create');
%%�˿����ý���

%%����Զ������ͼ��Monitor
monitor = invoke(mws, 'Monitor');
farfield_monitor = 2.1:0.05:2.6;
for i = 1:length(farfield_monitor)
    Str_name = ['e-field (f=',num2str(farfield_monitor(i)),')'];
    invoke(monitor, 'Reset');
    invoke(monitor, 'Name', Str_name);
    invoke(monitor, 'Dimension', 'Volume');
    invoke(monitor, 'Domain', 'Frequency');
    invoke(monitor, 'FieldType', 'Farfield');
    invoke(monitor, 'Frequency', farfield_monitor(i));
    invoke(monitor, 'Create');
end
%%����Զ������ͼ��Monitor����

%%���濪ʼ
solver = invoke(mws, 'Solver');
invoke(solver, 'Start');
%%�������

%%������ֵ�Ż�S�����Ļ������õ�����һЩ�����������ο�
% for i=1:N
%     invoke(mws, 'StoreParameter', 'a', variable(i));
%     invoke(mws, 'Rebuild');
%     Solver = invoke(mws, 'Solver');
%     invoke(Solver, 'Start');
%     result = invoke(mws, 'Result1D', 'a1(1)1(1)');
%     numOfValue = invoke(result, 'GetN');
%     invoke(result, 'Save', 'E:\test.dat')
%     A = importdata('E:\test.dat', ' ', 4);
% end
release(pick);
release(monitor);
release(port);
release(brick);
release(solver);

% invoke(mws, 'Save');%����
% invoke(mws, 'Quit');%�˳�
% 
% 
% release(mws);
% release(cst);