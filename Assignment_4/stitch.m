function [] = stitch(im1_dir, im2_dir)



[m1,m2,m3,m4,t1,t2] = RANSAC(im1_dir, im2_dir);
current_params = [m1,m2,m3,m4,t1,t2];

im2_transformed = compute_new_img(imread(im2_dir), current_params);
imwrite(im2_transformed, "im2_transformed.pgm");

% [matches, scores, k1, k2] = keypoint_matching(im1, im2_transformed);

get_random_matchpoints(im1_dir, "im2_transformed.pgm");

end