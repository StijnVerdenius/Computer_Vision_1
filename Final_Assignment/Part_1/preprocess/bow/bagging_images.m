function bow_imgs = bagging_images(imgs, vocab, load_from_file, save_to_file, set_name, sift_method)
% converts many images to bag of words descriptor given a vocabulary

disp("started finding bag of words representations");

local_filename = "bow_"+set_name;

% load from cache if available
if (load_from_file && does_file_exist(local_filename)) 
    
    bow_imgs = load_cached_data(local_filename);
    
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
        bow_imgs(:,i) = double(bag_of_words(imgs(:,:,:,i), vocab, sift_method));
    end
    
    % save output to cache if requested
    if (save_to_file)
        cache_data(local_filename, bow_imgs);
    end

end

disp("finished finding bag of words representations");

end