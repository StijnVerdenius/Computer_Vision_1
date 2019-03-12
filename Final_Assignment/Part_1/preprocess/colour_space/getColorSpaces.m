function [gray_imgs, rgb_imgs, opponent_imgs] = getColorSpaces(imgs)
% Converts entire datasets colorspace to grayscale, rgb and opponent color
% space

% get shape
shape = size(imgs);

% get the dimension in which the different pictures live
batch_dimension = numel(size(imgs));

% this either ahs to be 2 or 4
assert(batch_dimension ==2 || batch_dimension == 4);

% init output
rgb_imgs = zeros(shape);
opponent_imgs = zeros(shape);
shape(batch_dimension-1) = round(shape(batch_dimension-1)/3); % grayscale has less dimensions
gray_imgs = zeros(shape);

% get the number of pics and loop over them
amount_of_imgs = size(imgs, batch_dimension);
for i = 1: amount_of_imgs
    
    % get current img
    if (batch_dimension == 2)
        img = reshape(imgs(:,i), 96,96,3);
    else
        img = imgs(:,:,:,i);
    end
    
    % convert
    gray_img = ConvertColorSpace(img, 'gray');
    rgb_img = ConvertColorSpace(img, 'rgb');
    opponent_img = ConvertColorSpace(img, 'opponent');
    
    % append to result
    if (batch_dimension == 2)
        
        gray_img = reshape(gray_img, 96*96, 1);
        gray_imgs(:,i) = gray_img;
        
        rgb_img = reshape(rgb_img, 96*96*3, 1);
        rgb_imgs(:,i) = rgb_img;
        
        opponent_img = reshape(opponent_img, 96*96*3, 1);
        opponent_imgs(:,i) = opponent_img;
        
    else
        
        gray_imgs(:,:,1,i) = gray_img;
        rgb_imgs(:,:,:,i) = rgb_img;
        opponent_imgs(:,:,:,i) = opponent_img;
        
    end
end


end