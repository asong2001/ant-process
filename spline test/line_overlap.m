% 判断两个条直线是否重合
function isOverlap = line_overlap(line1, line2)

% % input lines' starting pint and end pint
% x1 = [line1(1) line1(3)];
% y1 = [line1(2) line1(4)];
% 
% x2 = [line2(1) line2(3)];
% y2 = [line2(2) line2(4)];
% 
% p1 = polyfit(x1, y1, 1);
% p2 = polyfit(x2, y2, 1);

% 三点共线，围成的的三角形面积=0
sp = line1(1,1:2);
midp = line1(1,3:4);
ep = line2(1,3:4);
p = [sp 1; midp 1; ep 1];

s = abs(1/2*det(p));

if s < 1e-5
    isOverlap = true;
else
    isOverlap = false;
end