function [xs_,ys_] = compute_new_loc(xs, ys, params)
m1 = params(1);
m2 = params(2);
m3 = params(3);
m4 = params(4);
t1 = params(5);
t2 = params(6);
xs_ = zeros(length(xs),1);
ys_ = zeros(length(ys),1);

for i=1:length(xs)
  new_point = [m1 m2; m3 m4]*[xs(i); ys(i)] + [t1; t2];
  xs_(i) = new_point(1);
  ys_(i) = new_point(2);
end

end

