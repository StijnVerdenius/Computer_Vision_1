%Question 7

%Part 1 --------------------------------------------------------------------------------------------------
%(a)
figure(1)

subplot(2,3,1)
imshow(denoise('images/image1_saltpepper.jpg', 'box', 3))
title('3x3 saltpepper')

subplot(2,3,2)
imshow(denoise('images/image1_saltpepper.jpg', 'box', 5))
title('5x5 saltpepper')

subplot(2,3,3)
imshow(denoise('images/image1_saltpepper.jpg', 'box', 7))
title('7x7 saltpepper')

subplot(2,3,4)
imshow(denoise('images/image1_gaussian.jpg', 'box', 3))
title('3x3 gaussian')

subplot(2,3,5)
imshow(denoise('images/image1_gaussian.jpg', 'box', 5))
title('5x5 gaussian')

subplot(2,3,6)
imshow(denoise('images/image1_gaussian.jpg', 'box', 7))
title('7x7 gaussian')

%(b)
figure(2)

subplot(2,3,1)
imshow(denoise('images/image1_saltpepper.jpg', 'median', 3))
title('3x3 saltpepper')

subplot(2,3,2)
imshow(denoise('images/image1_saltpepper.jpg', 'median', 5))
title('5x5 saltpepper')

subplot(2,3,3)
imshow(denoise('images/image1_saltpepper.jpg', 'median', 7))
title('7x7 saltpepper')

subplot(2,3,4)
imshow(denoise('images/image1_gaussian.jpg', 'median', 3))
title('3x3 gaussian')

subplot(2,3,5)
imshow(denoise('images/image1_gaussian.jpg', 'median', 5))
title('5x5 gaussian')

subplot(2,3,6)
imshow(denoise('images/image1_gaussian.jpg', 'median', 7))
title('7x7 gaussian')

%Part 2 --------------------------------------------------------------------------------------------------

%Saltpepper:
%Box:

%3x3
sb3 = myPSNR('images/image1_saltpepper.jpg', denoise('images/image1_saltpepper.jpg', 'box', 3));
%5x5
sb5 = myPSNR('images/image1_saltpepper.jpg', denoise('images/image1_saltpepper.jpg', 'box', 5));
%7x7
sb7 = myPSNR('images/image1_saltpepper.jpg', denoise('images/image1_saltpepper.jpg', 'box', 7));

%Median

%3x3
sm3 = myPSNR('images/image1_saltpepper.jpg', denoise('images/image1_saltpepper.jpg', 'median', 3));
%5x5
sm5 = myPSNR('images/image1_saltpepper.jpg', denoise('images/image1_saltpepper.jpg', 'median', 5));
%7x7
sm7 = myPSNR('images/image1_saltpepper.jpg', denoise('images/image1_saltpepper.jpg', 'median', 7));

%Gaussian:
%Box:

%3x3
gb3 = myPSNR('images/image1_gaussian.jpg', denoise('images/image1_saltpepper.jpg', 'box', 3));
%5x5
gb5 = myPSNR('images/image1_gaussian.jpg', denoise('images/image1_saltpepper.jpg', 'box', 5));
%7x7
gb7 = myPSNR('images/image1_gaussian.jpg', denoise('images/image1_saltpepper.jpg', 'box', 7));

%Median

%3x3
gm3 = myPSNR('images/image1_gaussian.jpg', denoise('images/image1_saltpepper.jpg', 'median', 3));
%5x5
gm5 = myPSNR('images/image1_gaussian.jpg', denoise('images/image1_saltpepper.jpg', 'median', 5));
%7x7
gm7 = myPSNR('images/image1_gaussian.jpg', denoise('images/image1_saltpepper.jpg', 'median', 7));

Filtering = {'Box 3x3'; 'Box 5x5'; 'Box 7x7';'Median 3x3';'Median 5x5';'Median 7x7'};
saltpepper = [sb3;sb5;sb7;sm3;sm5;sm7];
gaussian = [gb3;gb5;gb7;gm3;gm5;gm7];

T = table(Filtering, saltpepper, gaussian)


%Part 4 --------------------------------------------------------------------------------------------------

figure(3)

imshow(denoise('images/image1_gaussian.jpg', 'gaussian', 3, 5))


%Part 5 --------------------------------------------------------------------------------------------------

get_sds('images/image1_gaussian.jpg', 5)



