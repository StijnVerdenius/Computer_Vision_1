function [output_image] = rgb2lightness_gray(input_image)
% converts image to grayscale using the lightness method

output_image = (max(input_image, [], 3) + min(input_image, [], 3)) ./ 2;

end