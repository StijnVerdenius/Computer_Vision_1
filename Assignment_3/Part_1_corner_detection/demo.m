% original image
im = imread("person_toy\00000001.jpg");

% rotated versions
im45 = imrotate(im, 45);
im90 = imrotate(im, 90);

% fine-tuned parameters
window = 7;
threshold = 10;

% corner detection for original and rotated versions
[H, r, c] = harris_corner_detector(im, window, threshold);
[H45, r45, c45] = harris_corner_detector(im45, window, threshold);
[H90, r90, c90] = harris_corner_detector(im90, window, threshold);
