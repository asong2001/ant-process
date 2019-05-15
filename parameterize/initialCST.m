function initialCST(mws)

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

disp('初始化完成');
