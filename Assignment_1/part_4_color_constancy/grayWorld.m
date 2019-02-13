function [] = grayWorld(image)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

img = imread(image);

img_lin = rgb2lin(img);

illuminant = illumgray(img_lin);

c_img_lin = chromadapt(img_lin,illuminant,'ColorSpace','linear-rgb');

c_img = lin2rgb(c_img_lin);

figure(1)

subplot(2,1,1)
imshow(img)
title('Original image')

subplot(2,1,2)
imshow(c_img)
title('Corrected image')

end