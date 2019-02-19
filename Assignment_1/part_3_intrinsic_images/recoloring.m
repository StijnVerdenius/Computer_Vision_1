%% main script recoloring

clear
clc
close all

% load
original_im = imread("ball.png");
albedo_im = imread("ball_albedo.png");
shading_im = imread("ball_shading.png");

% initial distribution plot
figure(1)
[x, yR, yB, yG] = colour_distribution(albedo_im);
plot(x, yR, 'Red', x, yG, 'Green', x, yB, 'Blue');
title("Colour Distribution - Albedo")

% preprocessing
greenalbedo_im = albedo_im;
greenalbedo_im(:, :, [1 3]) = 0;
puregreen_im = uint8(uint16(greenalbedo_im) .* uint16(shading_im) ./ 255);

% plot
figure(2)
% add overall title
try
    sgtitle("Recolouring")
catch
    fprintf("sgtitle function not present in your matlab version, will proceed to ignore")
end

subplot(1, 3, 1)
imshow(original_im)
title("original")

subplot(1, 3, 2)
imshow(greenalbedo_im)
title("green albedo")

subplot(1, 3, 3)
imshow(puregreen_im)
title("green recoloured")

% final plot
figure(3)
[x, yR, yB, yG] = colour_distribution(puregreen_im);
plot(x, yR, 'Red', x, yG, 'Green', x, yB, 'Blue');
title("Colour Distribution - pure green")

% end
