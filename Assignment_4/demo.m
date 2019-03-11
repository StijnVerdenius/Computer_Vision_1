
% Compute parameters of img1 to img2 to transform
[m1,m2,m3,m4,t1,t2] = RANSAC('boat2.pgm','boat1.pgm');
current_params = [m1,m2,m3,m4,t1,t2];

% Show transform of img1 to img2
compute_new_img(imread('boat2.pgm'), current_params);
