function S = tri_area(p1,p2,p3)
% p1,2,3 ฮช1x2สýื้
p = [p1; p2; p3];
matrix = ones(3);
for k = 1:3
        matrix(2:3,k) = (p(k,:))';
end
S = abs(1/2 * det(matrix));