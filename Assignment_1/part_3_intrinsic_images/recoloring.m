original_im = imread("ball.png");
albedo_im = imread("ball_albedo.png");
shading_im = imread("ball_shading.png");

puregreen_im = original_im;
puregreen_im(:,:,[1,3]) = 0;

figure(1)

subplot(1, 2, 1)
imshow(original_im)
title("original")

subplot(1, 2, 2)
imshow(puregreen_im)
title("pure green")
