%% save result figure
for k = 1:10
    file_name = ['D:\课题组\图像处理\ant-process\figure\',num2str(k),'.png'];
    figure(k);
    saveas(gcf,file_name);
end