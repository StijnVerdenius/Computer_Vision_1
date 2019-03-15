function descriptors = sift_descriptor_extraction(img, method)
% transforms image to sift descriptor (gray-scale only) (NOT FINISHED)

% TODO: include these somehow, not very clear from assignment
gray_img = ConvertColorSpace(img, 'gray'); % transform to grayscale
% [~] = ConvertColorSpace(img, 'opponent');

% TODO: presmoothing???

if (strcmp( method, "dense"))
    [~, descriptors] = vl_dsift(im2single(gray_img), 'step', 3, 'size', 9, 'fast'); % get descriptors
elseif (strcmp( method, "keypoint"))
    [~, descriptors] = vl_sift(im2single(gray_img)); % get descriptors
else
    error("unrecognized sift option: "+ method);

% TODO: tune vldsift parameters
% TODO: support rgb-sift and opponent-sift.
% TODO: check if the right descriptors are being returned.
% TODO: do we need the frames?

% [R, G, B] = getColorChannels(img);
% [O_1, O_2, O_3] = getColorChannels(opponent_img);

end