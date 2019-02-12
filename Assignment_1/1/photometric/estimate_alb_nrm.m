function [ albedo, normal ] = estimate_alb_nrm( image_stack, scriptV, shadow_trick)
%COMPUTE_SURFACE_GRADIENT compute the gradient of the surface
%   image_stack : the images of the desired surface stacked up on the 3rd
%   dimension
%   scriptV : matrix V (in the algorithm) of source and camera information
%   shadow_trick: (true/false) whether or not to use shadow trick in solving
%   	linear equations
%   albedo : the surface albedo
%   normal : the surface normal

[h, w, img_count] = size(image_stack);
if nargin == 2
    shadow_trick = true;
end
% create arrays for 
%   albedo (1 channel)
%   normal (3 channels)
albedo = zeros(h, w, 1);
normal = zeros(h, w, 3);

% =========================================================================
% YOUR CODE GOES HERE
% for each point in the image array
%   stack image values into a vector i
%   construct the diagonal matrix scriptI
%   solve scriptI * scriptV * g = scriptI * i to obtain g for this point
%   albedo at this point is |g|
%   normal at this point is g / |g|
for row = 1:h
    for column = 1:w
        i = reshape(image_stack(row, column, :), [img_count,1]);
        if all(i(:) == 0)
            continue 
        else
            if shadow_trick == true
                scriptI = diag(i);
                A = scriptI * scriptV;
                B = scriptI * i;
                g = pinv(A)*B; % Moore-Penrose pseudo-inverse
            else
                g = mldivide(i, scriptV);
            end
            albedo(h,w) = norm(g);
            normal(h,w,:) = g/norm(g);
            display(g);
        end
    end
end

imshow(albedo)
%display(albedo)

% =========================================================================