function scaled_src = scale(src, times, tag)
% src 为坐标
% times为缩放因子
%      vx   0  0
% S=0  vy   0
%       0    0  vz

% src为M*N的矩阵，M为点的个数
% S 为N*N的方阵
[M,N] = size(src);
scaled_src = zeros(M,N);
v = ones(1,N) * times;
S = diag(v);% 缩放矩阵
switch tag
        case 1
                %% 整体缩放
                for k = 1:M
                        % 当前进行缩放的行
                        tmpRow = src(k,:);
                        scaled_src(k,:) = tmpRow * S;
                end
                
                % 缩放倍率
                ratio = scaled_src(1,1) / src(1,1);
                disp(['整体缩放倍率',num2str(ratio)]);
                
        case 2
                %% x方向缩放
                S(:,[2,3,5,6]) = 1;
                S(:,[3,6]) = 0;
   
                for k = 1:M
                        % 当前进行缩放的行
                        tmpRow = src(k,:);
                        scaled_src(k,:) = tmpRow * S;
                end
                
                % 缩放倍率
                ratio = scaled_src(1,2) / src(1,2);
                disp(['x方向缩放倍率',num2str(ratio)]);
                
         case 3
                %% x方向缩放
                S(:,[1,3,4,6]) = 1;
   
                for k = 1:M
                        % 当前进行缩放的行
                        tmpRow = src(k,:);
                        scaled_src(k,:) = tmpRow * S;
                end
                
                % 缩放倍率
                ratio = scaled_src(1,1) / src(1,1);
                disp(['x方向缩放倍率',num2str(ratio)]);
                
        case 4
                %% x方向缩放
                S(:,[1,2,4,5]) = 1;
   
                for k = 1:M
                        % 当前进行缩放的行
                        tmpRow = src(k,:);
                        scaled_src(k,:) = tmpRow + tmpRow * (S-1);
                end
                
                % 缩放倍率
                ratio = scaled_src(1,1) / src(1,1);
                disp(['x方向缩放倍率',num2str(ratio)]);
end