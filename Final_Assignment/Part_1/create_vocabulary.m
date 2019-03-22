function vocabulary = create_vocabulary(imgs, number_of_clusters, load_from_file, save_to_file, cache_version, apply_sampling, number_of_samples, colorspace)	 % DOCSTRING_GENERATED
 % CREATE_VOCABULARY		 [creates a visual vocabulary to be used]
 % INPUTS 
 %			imgs = self explanatory
 %			number_of_clusters = vocabulary size
 %			load_from_file = boolean for loading from cache file
 %			save_to_file = boolean for saving to cache file
 %			cache_version = to specify which vocabulary
 %			apply_sampling = boolean, whether to cluster on subset descriptors
 %			number_of_samples = if we sample, how many do we use
 %			colorspace = 'grayscale', 'rgb' or 'opponent'
 % OUTPUTS 
 %			vocabulary = self explanatory

 
disp("Start building vocabulary");

local_filename = "vocabulary";

% if load from cache and the file exists, load from cach
if (load_from_file && does_file_exist(local_filename, cache_version)) 
    
    vocabulary = load_cached_data(local_filename, cache_version);
    
else

    % get descriptors from all images
    descriptors = get_descriptors(imgs, colorspace);
    
    % generate vocabulary out of it
    vocabulary = find_clusters(descriptors, number_of_clusters, apply_sampling, number_of_samples);
    
    % save to cache if needed
    if (save_to_file)
       
        cache_data(local_filename, vocabulary, cache_version);
        
    end

end

disp("finished building vocabulary");

end