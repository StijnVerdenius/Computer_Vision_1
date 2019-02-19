%% main script image formation

clear
clc
close all

% load data
original_im = imread("ball.png");
albedo_im = imread("ball_albedo.png");
shading_im = imread("ball_shading.png");

% reconstruct image
reconstructed_im = uint16(albedo_im) .* uint16(shading_im);

% plot
figure(1)
% add overall title
try
    sgtitle("Image formation")
catch
    fprintf("sgtitle function not present in your matlab version, will proceed to ignore")
end

subplot(2, 2, 1)
imshow(albedo_im)
title("Albedo")

subplot(2, 2, 2)
imshow(shading_im)
title("Shading")

subplot(2, 2, 3)
imshow(original_im)
title("Original")

subplot(2, 2, 4)
imshow(reconstructed_im)
title("Reconstructed")

% calculate mean absolute error
mean_abs_error = mean(mean(mean(abs(original_im - reconstructed_im))));

% inform user
disp('reconstruction error is')
disp(mean_abs_error)

% end