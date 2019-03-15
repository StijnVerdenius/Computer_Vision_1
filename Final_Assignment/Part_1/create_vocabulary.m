function vocabulary = create_vocabulary(imgs, number_of_clusters, load_from_file, save_to_file)
% creates a visual vocabulary to be (EX. 2.2)

disp("Start building vocabulary");

local_filename = "vocabulary";

if (load_from_file && does_file_exist(local_filename)) 
    
    vocabulary = load_cached_data(local_filename);
    
else

    descriptors = get_descriptors(imgs);
    vocabulary = find_clusters(descriptors, number_of_clusters);
    
    if (save_to_file)
       
        cache_data(local_filename, vocabulary);
        
    end

end

disp("finished building vocabulary");

end