function [ imOut ] = denoise( image, kernel_type, varargin)

img = imread(image);

switch kernel_type
    case 'box'
        kernel_size = varargin{:};
        imOut = imboxfilt(img,kernel_size);
    case 'median'
        kernel_size = varargin{:};
        imOut = medfilt2(img,[kernel_size kernel_size]);
    case 'gaussian'
        kernel_size = varargin{1};
        sigma = varargin{2};
        imOut = imfilter(img, gauss2D(sigma , kernel_size));
end
end
