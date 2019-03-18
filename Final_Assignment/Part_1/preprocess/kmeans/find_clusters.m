function cluster_centers = find_clusters(descriptors, number_of_clusters)
% applies k-means to descriptors (NOT FINISHED)

disp("started finding clusters");

% get rid of order (bag of words paradigm)
unordered = reshape(descriptors, 128, size(descriptors, 2) * size(descriptors, 3));

% cluster descriptors, get cluster centroids
if (number_of_clusters < 1000)
    [cluster_centers] = vl_kmeans(unordered, number_of_clusters);
    
    
elseif(number_of_clusters<1500)    % TODO: test elkan, does it really work better for a 1000??
    [cluster_centers] = vl_kmeans(unordered, number_of_clusters,'algorithm', 'ELKAN');

else
    [cluster_centers] = vl_kmeans(unordered, number_of_clusters,'algorithm', 'ANN');
    
end

disp("finished finding clusters");

end