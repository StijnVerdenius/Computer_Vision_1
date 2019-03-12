function [new_img] = compute_new_img(img, params)
m1 = params(1);
m2 = params(2);
m3 = params(3);
m4 = params(4);
t1 = params(5);
t2 = params(6);
% img = rgb2gray(img);
[height, width] = size(img);

new_points = zeros(height,width, 2);
for h = 1:height
    for w = 1:width
        new_coord =  [m1 m2; m3 m4]*[h w]' + [t1 t2]';
        new_points(h,w,1) = new_coord(1);  
        new_points(h,w,2) = new_coord(2);
    end
end

max_h = max(max(new_points(:,:,1)));
max_w = max(max(new_points(:,:,2)));
min_h = min(min(new_points(:,:,1)));
min_w = min(min(new_points(:,:,2)));

new_img = ones(ceil(max_h-min_h),ceil(max_w-min_w)).*255;
[height, width, chs] = size(new_points);
truth_mat = false(ceil(max_h-min_h),ceil(max_w-min_w));
for h = 1:height
    for w = 1:width
        new_point_h = ceil(new_points(h,w,1) - min_h + 1);
        new_point_w = ceil(new_points(h,w,2) - min_w + 1);
        new_img(new_point_h,new_point_w) = img(h,w);
    end
end

imshow(new_img,[0 255]);
end

