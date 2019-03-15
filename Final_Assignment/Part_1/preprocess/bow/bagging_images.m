    function bow_imgs = bagging_images(imgs, vocab, load_from_file, save_to_file, set_name)
% converts many images to bag of words descriptor given a vocabulary (NOT FINISHED)

disp("started finding bag of words representations");

local_filename = "bow_"+set_name;

if (load_from_file && does_file_exist(local_filename)) 
    
    bow_imgs = load_cached_data(local_filename);
    
else

    % TODO: choose right size-dimension as soon as vocab is implemented
    vocab_size = size(vocab, 2);
    
    batch_dimension = numel(size(imgs));
    number_of_images = size(imgs, batch_dimension);
    if (batch_dimension == 2) % (EX. 1.1)

        imgs = reshape(imgs, 96, 96, 3, number_of_images);
    end
    
    bow_imgs = zeros(vocab_size,number_of_images, 'int16');
    
    for i = 1:number_of_images
        bow_imgs(:,i) = bag_of_words(imgs(:,:,:,i), vocab);
    end
    
    if (save_to_file)
       
        cache_data(local_filename, bow_imgs);
        
    end

end

disp("finished finding bag of words representations");

end