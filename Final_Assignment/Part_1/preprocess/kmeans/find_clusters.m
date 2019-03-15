function cluster_centers = find_clusters(descriptors, number_of_clusters)
% applies k-means to descriptors (NOT FINISHED)

disp("started finding clusters");

% get rid of order
unordered = reshape(descriptors, 128, size(descriptors, 2) * size(descriptors, 3));

% cluster descriptors, get cluster centroids
[cluster_centers] = vl_kmeans(unordered, number_of_clusters);

disp("finished finding clusters");

end