%%典型的VB命令转化为CST代码如下所示[1]:
% With Brick                                    brick = invoke(mws, 'Brick')
%     .Reset                                    invoke(brick, 'Reset');
%     .Name ("brick1")                          invoke(brick, 'Name', "brick1");
%     .Component ("component1")                 invoke(brick, 'Component', "component1");
%     .Material ("PEC")               ==》      invoke(brick, 'Material', "PEC");
%     .Xrange (0, 2)                            invoke(brick, 'Xrange', 0, 2);
%     .Yrange (0, 3)                            invoke(brick, 'Yrange', 0, 3);
%     .Zrange (0, "a+3")                        invoke(brick, 'Zrange', '0', num2str(a+3));
%     .Create                                   invoke(brick, 'Create');
% End With                                      release(brick);
%基本思路就是找出mws中需要操作的对象，然后对其所有参数进行赋值或者执行命令，然后释放对象

% 建模

function modelling(position)
    %%模型文件初始化
    cst = actxserver('CSTStudio.application');%首先载入CST应用控件
    mws = invoke(cst, 'NewMWS');%新建一个MWS项目
    app = invoke(mws, 'GetApplicationName');%获取当前应用名称
    ver = invoke(mws, 'GetApplicationVersion');%获取当前应用版本号
    %filename='E:\Matlab控制CST建模仿真优化\test1.cst';%可以将文件路径和文件名字分开写
    %invoke(mws, 'OpenFile', filename);%打开一个存在的CST文件
    invoke(mws, 'FileNew');%新建一个CST文件
    filename='./model.cst';%可以将文件路径和文件名字分开写
    invoke(mws, 'SaveAs', filename, 'True');%True表示保存到目前为止的结果
    invoke(mws, 'DeleteResfults');%删除之前的结果。注：在有结果的情况下修改模型会出现弹窗提示是否删除结果，这样运行的程序会停止，需等待手动点击弹窗使之消失
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

    %%建模开始
    %%调用Brick对象开始
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
