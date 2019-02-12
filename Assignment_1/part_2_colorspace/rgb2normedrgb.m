function [output_image] = rgb2normedrgb(input_image)
% converts an RGB image into normalized rgb

% get sum over the color-channel axis
RGB = double(sum(input_image, 3));

% Divide each element by said sum
output_image = uint8((double(input_image) ./ RGB )*255) ;

end

