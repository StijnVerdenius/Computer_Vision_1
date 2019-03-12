function [matches, scores, k1, k2] = keypoint_matching(image1, image2)

%Check if image is rgb and convert to gray if necessary
if ndims(imread(image1)) == 3
    I1 = rgb2gray(imread(image1));
else
    I1 = imread(image1);
end
  
if ndims(imread(image2)) == 3
    I2 = rgb2gray(imread(image2));
else
    I2 = imread(image2);
end   

%resize images to be of equal dimensions if necessary
% if size(I1) ~= size(I2)
%     I2 = imresize(I2,size(I1));
% end

%convert to singles
I1 = im2single(I1);
I2 = im2single(I2);

%Extract keypoints and their descriptions
[k1,d1] = vl_sift(I1);
[k2,d2] = vl_sift(I2);


%Get matching keypoints
[matches, scores] = vl_ubcmatch(d1, d2);

end

