function result = tracking(images)

first_img = images(1).data;

[H, R, C] = harris_corner_detector(first_img);

result = [];

current_R = R;
current_C = C;

result = [result ; current_R, current_C];

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
    
    current_R = current_R + vectors;
    current_C = current_C + vectors;
    
    result = [result ; current_R, current_C];
end

end