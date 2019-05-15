function newSrc = updateMoveLine(src, newLinek, lineNumToMove, dim)
newSrc = src;
if dim == 2
        if lineNumToMove == 1
                newSrc(lineNumToMove,:) = newLinek;
                newSrc(lineNumToMove+1,[1,2]) = newLinek(4:5);
                newSrc(end,[4,5]) = newLinek(1:2);
        else
                newSrc(lineNumToMove,:) = newLinek;
                newSrc(lineNumToMove-1,[4,5]) = newLinek(1:2);
                newSrc(lineNumToMove+1,[1,2]) = newLinek(4:5);
        end
end