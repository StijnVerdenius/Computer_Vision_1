% Script for testing
image_dir = './images/image2.jpg';
img = imread(image_dir);
[Gx, Gy, im_magnitude,im_direction]  = compute_gradient(img);
imshow(Gx);
imshow(Gy);
imshow(im_magnitude);
imshow(im_direction);