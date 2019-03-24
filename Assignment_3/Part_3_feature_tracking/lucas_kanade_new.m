function [vx, vy] = lucas_kanade_new(image1, image2, fracture, points)

% convert to standardized
image1 = im2double(rgb2gray(image1));
image2 = im2double(rgb2gray(image2));

% get derivatives
diff_image_total = diff(cat(3, image1, image2), 1, 3);
diff_image1_y = diff(image1, 1, 1);
diff_image1_x = diff(image1, 1, 2);

% initialize
vy = zeros(1, size(points, 2));
vx = zeros(1, size(points, 2));

for i=1:size(points, 2)
    
    currentPoint = points(:, i);
    
    % get corresponding block region
    horizontal_termination_index = round(currentPoint(1) + floor(fracture / 2));
    vertical_termination_index = round(currentPoint(2) + floor(fracture / 2));
    vertical_start_index = round(currentPoint(2) - floor(fracture / 2));
    horizontal_start_index = round(currentPoint(1) - floor(fracture / 2));

    % continue if not fallen off adge
    if (~( (vertical_start_index < 1) ||  (vertical_termination_index > size(diff_image1_x, 2)) || (horizontal_start_index < 1) || (horizontal_termination_index > size(diff_image1_y, 1))))
        
        % Find region
        total_image_region = diff_image_total( horizontal_start_index:horizontal_termination_index, vertical_start_index:vertical_termination_index);
        y_region = diff_image1_y( horizontal_start_index:horizontal_termination_index, vertical_start_index:vertical_termination_index );
        x_region = diff_image1_x( horizontal_start_index:horizontal_termination_index, vertical_start_index:vertical_termination_index );
        
        % Compute vector result
        b = -total_image_region(:);
        A = [x_region(:) y_region(:)];
        At = A';
        pseudo_inverse = inv(At*A)*At;
        v = pseudo_inverse*b;
        
        % Append result
        vy(i) = v(2);
        vx(i) = v(1);
              
    end
    
end

end
