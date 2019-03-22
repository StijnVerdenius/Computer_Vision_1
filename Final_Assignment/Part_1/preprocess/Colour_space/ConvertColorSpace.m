function [new_image] = ConvertColorSpace(input_image, colorspace)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Converts an RGB image into a specified color space, visualizes the 
% color channels and returns the image in its new color space.                     
%                                                        
% Colorspace options:                                    
%   opponent                                            
%   gray
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% convert image into double precision for conversions
input_image = im2double(input_image);

if strcmp(colorspace, 'opponent')
    
    new_image = rgb2opponent(input_image); % fill in this function
    
        
elseif strcmp(colorspace, 'gray')
    
    new_image = rgb2luminosity_gray(input_image); % fill in this function
    
else
    
% if user inputs an unknow colorspace just notify and do not plot anything
    fprintf('Error: Unknown colorspace type [%s]...\n',colorspace);
    new_image = input_image;
    return;
    
end

end