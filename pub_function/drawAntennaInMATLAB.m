% 根据坐标在MATLAB中画图
function drawAntennaInMATLAB(coordinate,color)
figure(99);
xodd = coordinate(:,1);
yodd = coordinate(:,2);
zodd = coordinate(:,3);

xeven = coordinate(:,4);
yeven = coordinate(:,5);
zeven = coordinate(:,6);

hold on;
for k = 1:length(coordinate)
        xk = [xodd(k); xeven(k)];
        yk = [yodd(k); yeven(k)];
        zk = [zodd(k); zeven(k)];
        pause(0.1);
        line(xk,yk,zk,'Color',color);
        
end
plot(coordinate(:,1), coordinate(:,2), '*');
title('天线边缘图');
