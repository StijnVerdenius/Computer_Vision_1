function [output_image] = rgb2average_gray(input_image)
% converts image to grayscale using the average method

[R,G,B] = getColorChannels(input_image);
output_image = (R + G + B) ./ 3;

end