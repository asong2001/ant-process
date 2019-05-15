function scaled_src = scale(src, times, tag)
% src Ϊ����
% timesΪ��������
%      vx   0  0
% S=0  vy   0
%       0    0  vz

% srcΪM*N�ľ���MΪ��ĸ���
% S ΪN*N�ķ���
[M,N] = size(src);
scaled_src = zeros(M,N);
v = ones(1,N) * times;
S = diag(v);% ���ž���
switch tag
        case 1
                %% ��������
                for k = 1:M
                        % ��ǰ�������ŵ���
                        tmpRow = src(k,:);
                        scaled_src(k,:) = tmpRow * S;
                end
                
                % ���ű���
                ratio = scaled_src(1,1) / src(1,1);
                disp(['�������ű���',num2str(ratio)]);
                
        case 2
                %% x��������
                S(:,[2,3,5,6]) = 1;
                S(:,[3,6]) = 0;
   
                for k = 1:M
                        % ��ǰ�������ŵ���
                        tmpRow = src(k,:);
                        scaled_src(k,:) = tmpRow * S;
                end
                
                % ���ű���
                ratio = scaled_src(1,2) / src(1,2);
                disp(['x�������ű���',num2str(ratio)]);
                
         case 3
                %% x��������
                S(:,[1,3,4,6]) = 1;
   
                for k = 1:M
                        % ��ǰ�������ŵ���
                        tmpRow = src(k,:);
                        scaled_src(k,:) = tmpRow * S;
                end
                
                % ���ű���
                ratio = scaled_src(1,1) / src(1,1);
                disp(['x�������ű���',num2str(ratio)]);
                
        case 4
                %% x��������
                S(:,[1,2,4,5]) = 1;
   
                for k = 1:M
                        % ��ǰ�������ŵ���
                        tmpRow = src(k,:);
                        scaled_src(k,:) = tmpRow + tmpRow * (S-1);
                end
                
                % ���ű���
                ratio = scaled_src(1,1) / src(1,1);
                disp(['x�������ű���',num2str(ratio)]);
end