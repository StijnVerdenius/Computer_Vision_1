function [x,x_,y,y_] = get_points_from_matches(T,k1, k2, subset)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
x  = k1(1,T(1,subset));
x_ = k2(1,T(2,subset));
y  = k1(2,T(1,subset));
y_ = k2(2,T(2,subset));
end

