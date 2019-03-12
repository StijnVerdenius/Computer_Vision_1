function descriptors = sift_descriptor_extraction(img)
% transforms image to sift descriptor (gray-scale only) (NOT FINISHED)

% TODO: support rgb-sift and opponent-sift.
% TODO: check if the right descriptors are being returned.
% TODO: do we need the frames?
[frames, descriptors] = vl_dsift(im2single(img));

end