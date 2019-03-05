function result = tracking(images)

first_img = images(1);

[H, c, s] = harris_corner_detector(first_img(0));

result = 0;

current_c = 0;
current_s = 0;

for index = 1:numel(images)-1
    img1 = images(index).data;
    img2 = images(index+1).data;
    
    if chs > 1
        grayImg1 = rgb2gray(img1);
        grayImg2 = rgb2gray(img2);
    else
        grayImg1 = img1;
        grayImg2 = img2;
    end
    
    regions1 = divide_in_regions(grayImg1,15);
    regions2 = divide_in_regions(grayImg2,15);
    
    % Calculate velocities
    vectors = calc_velocity(regions1,regions2);
    
    current_c = current_c + vectors;
    current_s = current_s + vectors;
    
    result = [result ; current_c, current_s];
end



end