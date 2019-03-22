function bow_imgs = bagging_images(imgs, vocab, load_from_file, save_to_file, set_name, sift_method, cache_version, colorspace)	 % DOCSTRING_GENERATED
 % BAGGING_IMAGES		 [converts many images to bag of words representation given a vocabulary]
 % INPUTS 
 %			imgs = images
 %			vocab = vocabulary
 %			load_from_file = boolean, load from cache file or not
 %			save_to_file = boolean, save to cache file or not
 %			set_name = 'train' or 'test'
 %			sift_method = 'keypoint' or 'dense'
 %			cache_version = to specify which vocabulary
 %			colorspace = 'grayscale', 'rgb' or 'opponent'
 % OUTPUTS 
 %			bow_imgs = bag of words representations of all images


disp("started finding bag of words representations");

local_filename = "bow_"+set_name;

% load from cache if available
if (load_from_file && does_file_exist(local_filename, cache_version)) 
    
    bow_imgs = load_cached_data(local_filename, cache_version);
    
else

    vocab_size = size(vocab, 2);
    
    
    batch_dimension = numel(size(imgs));
    number_of_images = size(imgs, batch_dimension);
    
    % reshape if needed
    if (batch_dimension == 2) % (EX. 1.1)
        imgs = reshape(imgs, 96, 96, 3, number_of_images);
    end
    
    % init output
    bow_imgs = zeros(vocab_size,number_of_images, 'double');
    
    % generate bow-representation for each image
    for i = 1:number_of_images
        bow_imgs(:,i) = double(bag_of_words(imgs(:,:,:,i), vocab, sift_method, colorspace));
    end
    
    % save output to cache if requested
    if (save_to_file)
        cache_data(local_filename, bow_imgs, cache_version);
    end

end

disp("finished finding bag of words representations");

end