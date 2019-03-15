function descriptors = sift_descriptor_extraction(img, opponent_img, gray_img)
% transforms image to sift descriptor (gray-scale only) (NOT FINISHED)

[~, descriptor] = vl_dsift(im2single(gray_img));
a = 0;

% TODO: support rgb-sift and opponent-sift.
% TODO: check if the right descriptors are being returned.
% TODO: do we need the frames?
[R, G, B] = getColorChannels(img);
[O_1, O_2, O_3] = getColorChannels(opponent_img);

concat = cat(3, R, G, B, O_1, O_2, O_3);

dims = size(img);
dims = [dims, size(concat, 3)];

descriptors = vl_dsift(im2single(gray_img));

for channel = 1:dims(3)
    [~, descriptor] = vl_dsift(im2single(concat(:, :, channel)));
    descriptors = cat(3, descriptors, descriptor);
end

a = 0;

end