function [A,b] = build_A_b(x, x_, y, y_)
A = [x(1) y(1) 0 0 1 0; 0 0 x(1) y(1) 0 1];
b = [x_(1); y_(1)];
for point = 2:size(x)+1
    A = [A;[x(point) y(point) 0 0 1 0; 0 0 x(point) y(point) 0 1]];
    b = [b; [x_(point); y_(point)]];
end
end

