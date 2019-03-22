function cluster_centers = find_clusters(descriptors, number_of_clusters, apply_sampling, number_of_samples)	 % DOCSTRING_GENERATED
 % FIND_CLUSTERS		 [finds clusters in descriptor space]
 % INPUTS 
 %			descriptors = training images in the form of descriptors
 %			number_of_clusters = self explanatory
 %			apply_sampling = boolean, whether to cluster on subset descriptors
 %			number_of_samples =  if we sample, how many do we use
 % OUTPUTS 
 %			cluster_centers = found cluster centroids


disp("started finding clusters");

% get rid of order (bag of words paradigm)
unordered = reshape(descriptors, 128, size(descriptors, 2) * size(descriptors, 3));

% possibly apply sampling
if (apply_sampling)
    max = size(unordered, 2);
    indices = randi(max,number_of_samples,1);
    unordered= unordered(:, indices);
end

% get cluster centroids, use the most efficient algorithm for number_of_clusters
if (number_of_clusters < 1000)
    [cluster_centers] = vl_kmeans(unordered, number_of_clusters);   
elseif (number_of_clusters < 1500)    
    [cluster_centers] = vl_kmeans(unordered, number_of_clusters,'algorithm', 'ELKAN');
else
    [cluster_centers] = vl_kmeans(unordered, number_of_clusters,'algorithm', 'ANN');
end

disp("finished finding clusters");

end
