function initialCST(mws)

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

disp('��ʼ�����');
