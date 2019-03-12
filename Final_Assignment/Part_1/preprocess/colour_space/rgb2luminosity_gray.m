function [output_image] = rgb2luminosity_gray(input_image)
% converts image to grayscale using the luminosity method

[R,G,B] = getColorChannels(input_image);
output_image = 0.21 .* R + 0.72 .* G + 0.07 .* B;

end