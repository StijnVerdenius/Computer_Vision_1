function [points, veccies] = tracking(images)

fracture = 4;

% get the first frame of video
first_img = images(1).data;

% get initial corners (r= row, c = column of each point)
[~, R, C] = harris_corner_detector(first_img, 7, 10);

% set firsts for tracking
current_R = R(1:end);
current_C = C(1:end);
timestep = cat(3, current_R, current_C);
points = cat(1, timestep);
veccies = zeros(size(points));

% for each frame update corners by their velocity
for index = 1:numel(images)-1
    
    % turn to gray for velocity calculation
    grayImg1 = images(index).data;
    grayImg2 = images(index+1).data;
    
    % split in regions16
    regions1 = divide_in_regions(rgb2gray(grayImg1), fracture);
    regions2 = divide_in_regions(rgb2gray(grayImg2), fracture);
    
    % Calculate velocities for regions
    [Vxs,Vys] = calc_velocity(regions1, regions2); %phillip(rgb2gray(grayImg1), rgb2gray(grayImg2), false, fracture);
    
    vecX = zeros(size(current_R));
    vecY = zeros(size(current_C));
    
    multiplication = 120;
    
    for in = 1:numel(vecX)
        
        x_location = round(current_C(in) / size(Vxs, 2));
        y_location = round(current_R(in) /  size(Vys, 1));
        
        vecY(in) = Vys(y_location+1, x_location+1).*multiplication;
        vecX(in) = Vxs(y_location+1, x_location+1).*multiplication;
    end
    
    % add velocities as vector to current 
    current_R = current_R + vecY;
    current_C = current_C + vecX;

    % append result
    timestep = cat(3, current_R, current_C);
    points = cat(1, points, timestep);
    timestep = cat(3, vecX, vecY);
    veccies = cat(1, veccies, timestep);
end
end