function [matches, scores] = keypoint_matching(image1, image2)

I1 = single(rgb2gray(imread(image1)));
I2 = single(rgb2gray(imread(image2)));


[k1,d1] = vl_sift(I1);
[k2,d2] = vl_sift(I2);

[matches, scores] = vl_ubcmatch(d1, d2);

end

