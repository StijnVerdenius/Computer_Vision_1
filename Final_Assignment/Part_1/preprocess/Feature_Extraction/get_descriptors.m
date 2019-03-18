function descriptors = get_descriptors(imgs, colorspace) % (EX. 2.1)
% generates descriptors for multiple images 

disp("start generating descriptors");

% TODO: check after implementing opponent and rgb sift that it still works

% change images to right shape, can be ignored
batch_dimension = numel(size(imgs));
number_of_images = size(imgs, batch_dimension);
if (batch_dimension == 2)
    imgs = reshape(imgs, 96, 96, 3, number_of_images);
end

% get initial descriptor in order to see its shape
test_descriptor = sift_descriptor_extraction(imgs(:,:,:,1), "dense", colorspace);

% initialize output shape
descriptors = zeros(128, size(test_descriptor, 2), number_of_images, 'uint8');

% get sift descriptors for each image
for i =1:number_of_images
    current_img = imgs(:, :, :, i);
    current_descriptors = sift_descriptor_extraction(current_img, "dense", colorspace);
    descriptors(:,:,i) = current_descriptors;
end

% change to single datatype for use in vl package functions
descriptors = im2single(descriptors);

disp("finished generating descriptors");

end