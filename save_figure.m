%% save result figure
for k = 1:10
    file_name = ['D:\������\ͼ����\ant-process\figure\',num2str(k),'.png'];
    figure(k);
    saveas(gcf,file_name);
end