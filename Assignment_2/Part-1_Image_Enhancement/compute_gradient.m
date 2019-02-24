function [Gx, Gy, im_magnitude,im_direction] = compute_gradient(image)
% Define Sobel kernels in x and y directions
kernel_x = [1 0 -1;2 0 -2; 1 0 -1];
kernel_y = [1 2 1;0 0 0; -1 -2 -1];
image = double(image) ./ 255
% Convolute to get derivatives
Gx = conv2(kernel_x, image);
Gy = conv2(kernel_y, image);

% Calc magnitude and dir
im_magnitude = sqrt(Gx.*Gx+Gy.*2);
im_direction = atan(Gy./Gx);

end

