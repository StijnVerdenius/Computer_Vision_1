function [output_image] = rgb2grays(input_image)
% converts an RGB into grayscale by using 4 different methods

% ligtness method
lightness = rgb2lightness_gray(input_image);

% average method
average = rgb2average_gray(input_image);
 
% luminosity method
luminosity = rgb2luminosity_gray(input_image);

% built-in MATLAB function
builtin = rgb2gray(input_image);

% combine all of the above
output_image  = cat(3, lightness, average, luminosity, builtin);

end

