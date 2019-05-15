function newLinek = moveLine(normalVector, linek, stepLength,dim)
% input normal vector = [x y]
% stepLength = ÒÆ¶¯³¤¶È
newLinek = zeros(1,6);
if dim == 2
        start_p = linek(1:2);
        end_p = linek(4:5);
        moveVector = normalVector .* stepLength;

        new_start = start_p + moveVector;
        new_end = end_p + moveVector;
        newLinek(1:2) = new_start;
        newLinek(4:5) = new_end;
end
