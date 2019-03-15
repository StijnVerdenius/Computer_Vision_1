function [new_img] = compute_new_img(img, params)
m1 = params(1);
m2 = params(2);
m3 = params(3);
m4 = params(4);
t1 = params(5);
t2 = params(6);

    
% img = rgb2gray(img);
[height, width,chs] = size(img);

new_points = zeros(height,width, 2);
for h = 1:height
    for w = 1:width
        new_coord =  [m1 m2; m3 m4]*[w h]' + [t1 t2]';
        new_points(h,w,:) = new_coord;  
    end
end

max_h = max(max(new_points(:,:,2)));
max_w = max(max(new_points(:,:,1)));
min_h = min(min(new_points(:,:,2)));
min_w = min(min(new_points(:,:,1)));

if ndims(img) == 3
    new_img = zeros(1,1,3);
else
    new_img = zeros(1,1,1);
end
        
[height2,width2, chs] = size(new_points);
for h = 1:height2
    for w = 1:width2
        new_point_w = floor(new_points(h,w,1) - min_w + 1);
        new_point_h = floor(new_points(h,w,2) - min_h + 1);
        new_img(new_point_h,new_point_w,:) = img(h,w,:);       
    end
end



end

