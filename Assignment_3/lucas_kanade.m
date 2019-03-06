% 1. Divide input images on non-overlapping regions, each region being 15 ×
% 15.
% 2. For each region compute A, A T and b. Then, estimate optical flow as
% given in Equation 20.
% 3. When you have estimation for optical flow (V x , V y ) of each region, you
% should display the results. There is a MATLAB function quiver which
% plots a set of two-dimensional vectors as arrows on the screen. Try to
% figure out how to use this to plot your optical flow results.
% if input images are 200 × 200, you should have an array of 13 × 13 optical
% flow vectors at the end of your procedure


% subplot(1,2,1);
% imshow('sphere1.ppm');
% subplot(1,2,2);
% imshow('sphere2.ppm');
% 
% 
% subplot(1,2,1);
% imshow('synth1.pgm');
% subplot(1,2,2);
% imshow('synth2.pgm');

% Read image
img1= imread('synth1.pgm');
img2= imread('synth2.pgm');
[h,w,chs] = size(img1);

% Convert to grey scale
if chs > 1
  grayImg1 = rgb2gray(img1);
  grayImg2 = rgb2gray(img2);
else
  grayImg1 = img1;
  grayImg2 = img2;
end
 
% Get regions
regions1 = divide_in_regions(grayImg1,15);
regions2 = divide_in_regions(grayImg2,15);

% Calculate velocities
[Vxs,Vys] = calc_velocity(regions1,regions2);

% Display resulting velocity fields
disp_velocity_field(Vxs,Vys,img1);
