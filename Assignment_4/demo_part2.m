im1_dir = "left.jpg";
im2_dir = "right.jpg";

im1 = imread(im1_dir);
im2 = imread(im2_dir);

imX = stitch(im1_dir, im2_dir);
figure(2)
subplot(1, 3, 1)
imshow(im1)
subplot(1, 3, 2)
imshow(im2)
subplot(1, 3, 3)
imshow(imX)