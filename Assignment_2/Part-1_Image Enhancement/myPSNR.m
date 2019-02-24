function [ PSNR ] = myPSNR( orig_image, approx_image ) 

if isrow(orig_image)
    I = im2double(imread(orig_image));
else
    I = im2double(orig_image);
end

if isrow(approx_image)
    I2 = im2double(imread(approx_image));
else
    I2 = im2double(approx_image);
end

[m,n] = size(I);

sum = 0;

for y = 1:n
    for x = 1:m
        sum = sum + (I(x,y) - I2(x,y))^2;
    end
end

MSE = (1/(m*n))*sum;

PSNR = 20 * log10((max(max(I))/sqrt(MSE)));


end

