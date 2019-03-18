function bow_norm = bag_of_words(img, vocab, sift_method)
% converts one image to bag of words descriptor given a vocabulary (NOT FINISHED)

% TODO: choose right size-dimension as soon as vocab is implemented
vocab_size = size(vocab, 2);

descriptors = sift_descriptor_extraction(img, sift_method); 
bow = zeros(vocab_size, 1);

for d = 1:size(descriptors,2)
    [~, best_cluster] = min(vl_alldist(double(descriptors(:,d)), double(vocab)));
    bow(best_cluster,1) = bow(best_cluster) + 1;
end


bow_norm = bow / norm(bow, 1); 

% TODO: match descriptors against vocab and then count (EX. 2.3). Subsequently,
% return bag of words frequencies for image (EX. 2.4)

% things to look at for matching: vl_feat buitlin function, 
% other inspirations: https://stackoverflow.com/questions/23104750/bag-of-words-bow-in-vlfeat

% output should be |V|x1
end