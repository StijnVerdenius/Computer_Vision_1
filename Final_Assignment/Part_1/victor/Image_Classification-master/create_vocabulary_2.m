function [vocabulary] = create_vocabulary_2(data, sampling_strategy, image_type, vocabulary_size, descriptor_type, cluster_type)
% Create a vocabulary from the given training data
disp("extracting features");


descriptors = [];
for i = 1:length(data)
    d = feature_extraction(data(:,:,:,i), sampling_strategy, image_type, descriptor_type);
    descriptors = [descriptors; d];
end

disp(size(descriptors));
disp("start kmeans features");

%k means
switch cluster_type
    case "kmeans"
        [~, vocabulary] = kmeans(double(descriptors).', vocabulary_size);
    case "kmedoids"
        [~, vocabulary] = kmedoids(double(descriptors), vocabulary_size);
    otherwise
        error("unknown clustering algorithm")
end

disp("done kmeans features");

end

