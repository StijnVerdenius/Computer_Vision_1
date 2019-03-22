function [output_image] = rgb2luminosity_gray(input_image)	 % DOCSTRING_GENERATED
 % RGB2LUMINOSITY_GRAY		 [converts image to grayscale using the luminosity method]
 % INPUTS 
 %			input_image = self explanatory
 % OUTPUTS 
 %			output_image = self explanatory

[R,G,B] = getColorChannels(input_image);
output_image = 0.21 .* R + 0.72 .* G + 0.07 .* B;

end