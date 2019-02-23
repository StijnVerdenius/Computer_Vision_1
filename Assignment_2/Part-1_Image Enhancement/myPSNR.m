function [ PSNR ] = myPSNR( orig_image, approx_image ) %NEED TO DEBUG!!

I = im2double(imread(orig_image));
I2 = im2double(imread(approx_image));
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

