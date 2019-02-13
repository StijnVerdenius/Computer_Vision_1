original_im = imread("ball.png");
albedo_im = imread("ball_albedo.png");
shading_im = imread("ball_shading.png");

figure(1)
color_distribution(albedo_im)
% title("Color Distribution - Uniform")

greenalbedo_im = albedo_im;
greenalbedo_im(:, :, [1 3]) = 0;
puregreen_im = uint8(uint16(greenalbedo_im) .* uint16(shading_im) ./ 255);

figure(2)
subplot(1, 3, 1)
imshow(original_im)
title("original")
subplot(1, 3, 2)
imshow(greenalbedo_im)
title("green albedo")
subplot(1, 3, 3)
imshow(puregreen_im)
title("green recolored")

figure(3)
color_distribution(puregreen_im)
title("Color Distribution - pure green")

function [] = color_distribution(im)
R = im(:,:,1);
G = im(:,:,2);
B = im(:,:,3);

[yR, ~] = imhist(R);
[yG, ~] = imhist(G);
[yB, x] = imhist(B);

plot(x, yR, 'Red', x, yG, 'Green', x, yB, 'Blue');

end
