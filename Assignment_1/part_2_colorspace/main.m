% test your code by using this simple script

clear
clc
close all

I = imread('peppers.png');

figure(1)
imshow(I)
title("Original image")

figure(2)
J = ConvertColorSpace(I,'opponent');
try
    sgtitle("Opponent color-space")
catch
    fprintf("sgtitle function not present in your matlab version, will proceed to ignore")
end
 
% close all
figure(3)
% title("Opponent color-space")
J = ConvertColorSpace(I,'rgb');
try
    
    sgtitle("Normalized-RGB color-space")
catch
    fprintf("sgtitle function not present in your matlab version, will proceed to ignore")
end

% close all
figure(4)
J = ConvertColorSpace(I,'hsv');
try
    sgtitle("HSV color-space")
catch
    fprintf("sgtitle function not present in your matlab version, will proceed to ignore")
end

% close all
figure(5)
J = ConvertColorSpace(I,'ycbcr');
try
    sgtitle("YCBCR color-space")
catch
    fprintf("sgtitle function not present in your matlab version, will proceed to ignore")
end

% close all
figure(6)
J = ConvertColorSpace(I,'gray');
try
    sgtitle("Grayscale variants")
catch
    fprintf("sgtitle function not present in your matlab version, will proceed to ignore")
end