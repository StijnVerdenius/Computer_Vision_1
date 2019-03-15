function descriptors_concat = sift_descriptor_extraction(img, method)
% transforms image to sift descriptor (gray-scale only) (NOT FINISHED)

descriptors = cell(7,1);

% TODO: include these somehow, not very clear from assignment
img_gray = ConvertColorSpace(img, 'gray'); % transform to grayscale
img_opp = ConvertColorSpace(img, 'opponent');

% TODO: presmoothing???

if (strcmp( method, "dense"))
    [~, descriptors{1}] = vl_dsift(im2single(img_gray), 'step', 3, 'size', 9, 'fast');
    for channel=1:3
        [~, descriptors{1 + channel}] = vl_dsift(im2single(img_opp(:, :, channel)), 'step', 3, 'size', 9, 'fast');
        [~, descriptors{4 + channel}] = vl_dsift(im2single(img(:, :, channel)), 'step', 3, 'size', 9, 'fast');
    end
elseif (strcmp( method, "keypoint"))
    [~, descriptors{1}] = vl_sift(im2single(img_gray)); % get descriptors
    for channel=1:3
        [~, descriptors{1 + channel}] = vl_sift(im2single(img_opp(:, :, channel)));
        [~, descriptors{4 + channel}] = vl_sift(im2single(img(:, :, channel)));
    end
else
    error("unrecognized sift option: "+ method);

descriptors_concat = cell2mat(descriptors);
    
% TODO: tune vldsift parameters
% TODO: support rgb-sift and opponent-sift.
% TODO: check if the right descriptors are being returned.
% TODO: do we need the frames?

% [R, G, B] = getColorChannels(img);
% [O_1, O_2, O_3] = getColorChannels(opponent_img);

end