function bow = bag_of_words(img, vocab)
% converts one image to bag of words descriptor given a vocabulary (NOT FINISHED)

% TODO: choose right size-dimension as soon as vocab is implemented
vocab_size = size(vocab, 2);

descriptors = sift_descriptor_extraction(img); 
bow = zeros(vocab_size, 1);


for d = 1:size(descriptors,2)
    descriptor = double(descriptors(:,d));
    best_cluster = -1;
    best_distance = intmax;
    for i= 1:vocab_size
        cluster_center = vocab(:,i);
        distance = norm(descriptor - cluster_center);
        if distance < best_distance
            best_distance = distance;
            best_cluster = i;
        end
    end
    bow(best_cluster,1) = bow(best_cluster) + 1;
end

% TODO: match descriptors against vocab and then count (EX. 2.3). Subsequently,
% return bag of words frequencies for image (EX. 2.4)

% things to look at for matching: vl_feat buitlin function, 
% other inspirations: https://stackoverflow.com/questions/23104750/bag-of-words-bow-in-vlfeat

% output should be |V|x1
end