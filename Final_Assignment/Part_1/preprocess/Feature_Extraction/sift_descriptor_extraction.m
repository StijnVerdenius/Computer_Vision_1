function descriptors = sift_descriptor_extraction(img)
% transforms image to sift descriptor (gray-scale only) (NOT FINISHED)

% TODO: include these somehow, not very clear from assignment
gray_img = ConvertColorSpace(img, 'gray');
[~] = ConvertColorSpace(img, 'opponent');


[~, descriptors] = vl_dsift(im2single(gray_img));

% TODO: tune vldsift parameters
% TODO: support rgb-sift and opponent-sift.
% TODO: check if the right descriptors are being returned.
% TODO: do we need the frames?


% [R, G, B] = getColorChannels(img);
% [O_1, O_2, O_3] = getColorChannels(opponent_img);


end