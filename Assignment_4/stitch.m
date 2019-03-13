function [newimage] = stitch(im1_dir, im2_dir)

% read images
im1 = imread(im1_dir);
im2 = imread(im2_dir);

% find best transformation
[m1,m2,m3,m4,t1,t2] = RANSAC(im1_dir, im2_dir);

% transform image2 according to best transformation
best_M = [m1 -m2; -m3 m4];
best_t = [t1; t2];
combined_matrix = cat(1, best_M', best_t');
tform = affine2d(combined_matrix);
im2_transformed = imwarp(im2, tform);
imwrite(im2_transformed, "im2_transformed.jpg");

% keypoint matching between image1 and transformed image2
[matches, scores, k1, k2] = keypoint_matching(im1_dir,  "im2_transformed.jpg");

% sort matches according to their score
[~, idx_sort] = sort(scores, "ascend");
matches = matches(:, idx_sort);
matches = matches(:, 1:5);

% get the x-y coordinates of the rightmost match from image1
positions_left = k1(1:2, matches(1, :));
[X1, idx] = max(positions_left(1, :));
X1  = round(X1);
Y1 = round(positions_left(2, idx));

% get the x-y coordinates of the coresponding match from image2
X2 = round(k2(1, matches(2, idx)));
Y2 = round(k2(2, matches(2, idx)));

% figure(1)
% subplot(1, 2, 1)
% imshow(im1)
% hold on;
% plot(X1, Y1, 'ro', 'LineWidth', 2, 'MarkerSize', 15);
% plot(X1, Y1, 'r.', 'LineWidth', 2, 'MarkerSize', 10);
% hold off;
% subplot(1, 2, 2)
% imshow(im2_transformed)
% hold on;
% plot(X2, Y2, 'ro', 'LineWidth', 2, 'MarkerSize', 15);
% plot(X2, Y2, 'r.', 'LineWidth', 2, 'MarkerSize', 10);
% hold off;

% pad image2 to match the first dimension of image1
% pad the difference of the y coordinates of the stiching point to the top
% pad the rest to the botoom
y_diff = Y1 - Y2;
im2_transformed = padarray(im2_transformed, [y_diff, 0], "pre");
im2_transformed = padarray(im2_transformed, [size(im1, 1) - size(im2_transformed, 1), 0], "post");

% stich image
newimage = [im1(:, 1:X1, :), im2_transformed(:, X2:end, :)];

end