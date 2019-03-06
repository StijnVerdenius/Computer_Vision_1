function [points, veccies] = tracking(images)

fracture = 16;

% get the first frame of video
first_img = images(1).data;

% get initial corners (r= row, c = column of each point)
[~, R, C] = harris_corner_detector(first_img, 7, 10);

% set firsts for tracking
current_R = R;
current_C = C;
timestep = cat(3, current_R, current_C);
points = cat(1, timestep);
veccies = zeros(size(points));

% for each frame update corners by their velocity
for index = 1:numel(images)-1
    
    % turn to gray for velocity calculation
    grayImg1 = images(index).data;
    grayImg2 = images(index+1).data;
    
    % split in regions
    regions1 = divide_in_regions(rgb2gray(grayImg1), fracture);
    regions2 = divide_in_regions(rgb2gray(grayImg2), fracture);
    
    % Calculate velocities for regions
    [Vxs,Vys] = calc_velocity(regions1,regions2);
    
    vecX = Vxs(round(current_R / fracture));
    vecY = Vys(round(current_C / fracture));
    
    % add velocities as vector to current 
    current_R = current_R + vecX;
    current_C = current_C + vecY;

    % append result
    timestep = cat(3, current_R, current_C);
    points = cat(1, points, timestep);
    timestep = cat(3, vecX, vecY);
    veccies = cat(1, veccies, timestep);
end
end