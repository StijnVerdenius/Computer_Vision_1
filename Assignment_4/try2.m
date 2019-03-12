im1_dir = "boat1.pgm";
im2_dir = "boat2.pgm";

im1 = imread(im1_dir);
im2 = imread(im2_dir);

[m1,m2,m3,m4,t1,t2] = RANSAC(im1_dir, im2_dir);
current_params = [m1,m2,m3,m4,t1,t2];

im2_transformed = compute_new_img(imread(im2_dir), current_params);
im2_transformed = imresize(im2_transformed, size(im1));
imwrite(im2_transformed, "im2_transformed.pgm");

[matches, scores, k1, k2] = keypoint_matching(im1_dir,  "im2_transformed.pgm");

[~, idx_sort] = sort(scores, "ascend");
matches = matches(idx_sort);
best_matches = matches(1:20);

[X1, point] = min(k1(2, best_matches));
X2 = k2(2, point);

newimage = [im1(:, 1:X1), im2_transformed(:, X2:end)];
figure(1)
imshow(newimage);
%% 

figure(1)
imshowpair(im1, im2_transformed , 'montage');

%plot matched features on 1st image
f1 = vl_plotframe(k1(:,best_matches));
set(f1,'color','b','linewidth',3) ;

%plot matched features on 2nd image 
k2(1,:) = k2(1,:) + size(im1,2);
f2 = vl_plotframe(k2(:,best_matches));
set(f2,'color','g','linewidth',3) ;

%plot lines joining matched features
x1 = k1(1,best_matches);
x2 = k2(1,best_matches);
y1 = k1(2,best_matches);
y2 = k2(2,best_matches);

f3 = line([x1 ; x2], [y1 ; y2]) ;
set(f3,'linewidth', 2, 'color', 'r') ;