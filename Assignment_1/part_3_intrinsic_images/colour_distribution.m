function [x, yR, yB, yG] = colour_distribution(im)
% function to retrieve color distribution for an input image

% split colour channels
R = im(:,:,1);
G = im(:,:,2);
B = im(:,:,3);

% obtain distribution
[yR, ~] = imhist(R);
[yG, ~] = imhist(G);
[yB, x] = imhist(B);

end