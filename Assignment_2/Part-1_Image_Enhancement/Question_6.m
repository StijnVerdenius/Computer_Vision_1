%Question 6

%Part 1
disp('The PSNR between image1 saltpepper.jpg and image1.jpg is:') 
myPSNR('images/image1_saltpepper.jpg', 'images/image1.jpg')

figure(1)

subplot(1,2,1)
imshow(imread('images/image1_saltpepper.jpg'))
title('Saltpepper image')

subplot(1,2,2)
imshow(imread('images/image1.jpg'))
title('Original image')

%Part 2
disp('the PSNR between image1 gaussian.jpg and image1.jpg is:') 
myPSNR('images/image1_gaussian.jpg', 'images/image1.jpg')

figure(2)

subplot(1,2,1)
imshow(imread('images/image1_gaussian.jpg'))
title('Gaussian image')

subplot(1,2,2)
imshow(imread('images/image1.jpg'))
title('Original image')