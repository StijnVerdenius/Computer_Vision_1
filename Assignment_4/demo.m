
%Question 1
% run('.../vlfeat-0.9.21-bin/vlfeat-0.9.21/toolbox/vl_setup.m');
% %Part 1
% [m,s] = keypoint_matching('boat1.pgm', 'boat2.pgm');
% 
% %Part 2
% get_random_matchpoints('boat1.pgm', 'boat2.pgm');


% Compute parameters of img1 to img2 to transform

% OUR VERSION
[m1,m2,m3,m4,t1,t2] = RANSAC('right.jpg','left.jpg');
current_params = [m1,m2,m3,m4,t1,t2];
transformed_image_us = compute_new_img(imread('left.jpg'),current_params);

% MATLAB VERSION
best_M = [m1 m2; m3 m4];
best_t = [t1; t2];
combined_matrix = cat(1, best_M', best_t');
tform = affine2d(combined_matrix);
image1 = imread('left.jpg');
transformed_image_matlab = imwarp(image1, tform);

subplot(1,2,1)
if ndims(transformed_image_us) == 3
    imshow(uint8(transformed_image_us),[0 255]);
else
    imshow(transformed_image_us,[0 255]);
end
title('Our transformation')  

subplot(1,2,2)
imshow(transformed_image_matlab);
title('Matlab transformation')  

display('over');