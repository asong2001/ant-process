% ��һ�ַ�ʽ����������
function [point_para_list] = createCSTPara2(mws, coordinate_src)
% �Ȱ���x,y����������ֵ
N = length(coordinate_src);
point_para_list = [];
for k = 1:N
        eval(['x', num2str(k), '=','coordinate_src(k,1)', ';']);
        eval(['y', num2str(k), '=','coordinate_src(k,2)', ';']);
        tmp = [...
                convertCharsToStrings(sprintf('x%d', k))...
                convertCharsToStrings(sprintf('y%d', k))...
                ];
        point_para_list = [point_para_list; tmp];
        
        X = ['x', num2str(k)];
        Y = ['y', num2str(k)];
        xx = coordinate_src(k,1);
        yy = coordinate_src(k,2);
        invoke(mws, 'StoreParameter', X, xx);% ������������ֵ
        invoke(mws, 'StoreParameter', Y, yy);
end