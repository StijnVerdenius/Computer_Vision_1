function result = tracking(images)

first_img = images(1).data;

[H, R, C] = harris_corner_detector(first_img, 7, 10);

result = [];

current_R = R;
current_C = C;

result = [result ; current_R, current_C];

for index = 1:numel(images)-1
    grayImg1 = images(index).data;
    grayImg2 = images(index+1).data;
    
    regions1 = divide_in_regions(rgb2gray(grayImg1), 16);
    regions2 = divide_in_regions(rgb2gray(grayImg2), 16);
    
    % Calculate velocities
    [Vxs,Vys] = calc_velocity(regions1,regions2);
    
    
    
    current_R = current_R + vectors;
    current_C = current_C + vectors;
    
    result = [result ; current_R, current_C];
end

end