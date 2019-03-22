function [output_image] = rgb2opponent(input_image)	 % DOCSTRING_GENERATED
 % RGB2OPPONENT		 [converts an RGB image into opponent color space]
 % INPUTS 
 %			input_image = self explanatory
 % OUTPUTS 
 %			output_image = self explanatory

% split image
[R, G, B] = getColorChannels(input_image);

% convert to double
R = double(R);
G = double(G);
B = double(B);

% get required sums
RG = double(R+G);
RGB = double(sum(input_image, 3));

% calculate opponents
O_1 = (R-G) ./ sqrt(2);
O_2 = (RG - (2 .* B)) ./ sqrt(6);
O_3 = RGB ./ sqrt(3);

% recombine image
output_image = cat(3, O_1, O_2, O_3);

end

