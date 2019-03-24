function [points, veccies] = tracking(images, magic_multiplication)

fracture = 15;

% get the first frame of video
first_img = images(1).data;

% get initial corners (r= row, c = column of each point)
[~, R, C] = harris_corner_detector(first_img, 7, 10);

% set firsts for tracking
current_Y = R(1:end);
current_X = C(1:end);
timestep = cat(3, current_X, current_Y);
points = cat(1, timestep);
veccies = zeros(size(points));

% for each frame update corners by their velocity
for index = 1:numel(images)-1
    
    % turn to gray for velocity calculation
    frame1 = images(index).data;
    frame2 = images(index+1).data;
    
    [vecX,vecY] = lucas_kanade_new(frame1,frame2,fracture,[current_Y;current_X]);
        
    % add velocities as vector to current 
    current_Y = current_Y + vecY .* magic_multiplication;
    current_X = current_X + vecX .* magic_multiplication;

    % append result
    timestep = cat(3, current_X, current_Y);
    points = cat(1, points, timestep);
    timestep = cat(3, vecX, vecY);
    veccies = cat(1, veccies, timestep);
end
end
