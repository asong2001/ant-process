% src https://blog.csdn.net/weixin_38215395/article/details/78858369 

%���ζ�ȡ���ɵ�����ͼƬ
for j=1:244
    %��ȡ��ǰͼƬ
    A=imread(sprintf('figure/%d.png',j));
    [I,map]=rgb2ind(A,256);
    %����gif��������
    if(j==1)
        imwrite(I,map,'movefig.gif','DelayTime',0.1,'LoopCount',Inf)
    else
        imwrite(I,map,'movefig.gif','WriteMode','append','DelayTime',0.1)    
    end
end