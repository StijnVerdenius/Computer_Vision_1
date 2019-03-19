function cluster_centers = find_clusters(descriptors, number_of_clusters, apply_sampling, number_of_samples)
% applies k-means to descriptors (NOT FINISHED)

disp("started finding clusters");

% get rid of order (bag of words paradigm)
unordered = reshape(descriptors, 128, size(descriptors, 2) * size(descriptors, 3));

if (apply_sampling)
    max = size(unordered, 2);
    indices = randi(max,number_of_samples,1);
    unordered= unordered(:, indices);
end

% cluster descriptors, get cluster centroids
tic %if (number_of_clusters < 1000)
[cluster_centers] = vl_kmeans(unordered, number_of_clusters);   
toc
tic %elseif(number_of_clusters<1500)    % TODO: test elkan, does it really work better for a 1000??
[cluster_centers] = vl_kmeans(unordered, number_of_clusters,'algorithm', 'ELKAN');
toc
tic%else
[cluster_centers] = vl_kmeans(unordered, number_of_clusters,'algorithm', 'ANN');
toc%end

disp("finished finding clusters");

end