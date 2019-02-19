%% main script

% close everything
clear
clc
close all

% add overall title
try
    sgtitle("Color correction using Grey-World algorithm")
catch
    fprintf("sgtitle function not present in your matlab version, will proceed to ignore")
end

% load image from path
img = imread('awb.jpg');

% do colour correction
c_img = grayWorld(img);

% plot
figure(1)

subplot(1,2,1)
imshow(img)
title('Original image')

subplot(1,2,2)
imshow(c_img)
title('Corrected image')

% end
