function [ imOut ] = denoise( image, kernel_type, varargin)

switch kernel_type
    case 'box'
        kernel_size = varargin{:};
        imOut = imboxfilt(image,kernel_size);
    case 'median'
        kernel_size = varargin{:};
        imOut = medfilt2(image,[kernel_size kernel_size]);
    case 'gaussian'
        kernel_size = varargin{1};
        sigma = varargin{2};
        imOut = imfilter(image, gauss2D(sigma , kernel_size));
end
end
