function descriptors = get_descriptors(imgs) % (EX. 2.1)
% generates descriptors for multiple images 

% TODO: check after implementing opponent and rgb sift that it still works

batch_dimension = numel(size(imgs));
number_of_images = size(imgs, batch_dimension);
if (batch_dimension == 2)
    imgs = reshape(imgs, 96, 96, 3, number_of_images);
end

test_descriptor = sift_descriptor_extraction(imgs(:,:,:,1));

descriptors = zeros(128, size(test_descriptor, 2), number_of_images);

for i =1:number_of_images
    
    current_img = imgs(:, :, :, i);
    current_descriptors = sift_descriptor_extraction(current_img);
    descriptors(:,:,i) = current_descriptors;
    
end

end