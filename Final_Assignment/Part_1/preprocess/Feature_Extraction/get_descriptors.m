function descriptors = get_descriptors(imgs) % (EX. 2.1)
% generates descriptors for multiple images (NOT FINISHED)

batch_dimension = numel(size(imgs));
number_of_images = size(imgs, batch_dimension);
if (batch_dimension == 2)
    imgs = reshape(imgs, 96, 96, 3, number_of_images);
end

% TODO: include these somehow, not very clear from assignment
[gray_imgs, normalized_imgs, opponent_imgs] = getColorSpaces(imgs);

descriptors = [];

for i =1:number_of_images
    
    current_img = gray_imgs(:, :, :, i); % TODO: gray, opponent, normal and/or normalized??
    current_descriptors = sift_descriptor_extraction(current_img);
    
    % TODO: make sure it is retracable to which image certain descriptors belonged too, i
    % don't think it is now. If we can't trace them back to a label we
    % cannot train on them.
    descriptors = cat(4, descriptors, current_descriptors);
    
end

end