function [new_img] = compute_new_img(img, params)
m1 = params(1);
m2 = params(2);
m3 = params(3);
m4 = params(4);
t1 = params(5);
t2 = params(6);
img = rgb2gray(img);
[height, width] = size(img);
new_img = zeros(height, width);
for h = 1:height
    for w = 1:width
        new_point = [m1 m2; m3 m4]*[w; h] + [t1; t2];
        new_x = round(new_point(1));
        new_y = round(new_point(2));
        if new_x < 1 || new_y < 1 || new_y > height || new_x > width
            new_img(h,w) = 0;
        else
            new_img(h,w) = img(new_y,new_x);
        end
    end
end
imshow(new_img,[0 255]);
end

