function vocabulary = create_vocabulary(imgs, number_of_clusters)
% creates a visual vocabulary to be (EX. 2.2)

descriptors = get_descriptors(imgs);
vocabulary = find_clusters(descriptors, number_of_clusters);

end