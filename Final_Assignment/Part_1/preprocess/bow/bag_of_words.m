function bow_norm = bag_of_words(img, vocab, sift_method, colorspace)	 % DOCSTRING_GENERATED
 % BAG_OF_WORDS		 [converts one image to bag of words descriptor given a vocabulary]
 % INPUTS 
 %			img = image
 %			vocab = vocabulary
 %			sift_method = 'keypoint' or 'dense'
 %			colorspace = 'grayscale', 'rgb' or 'opponent'
 % OUTPUTS 
 %			bow_norm = normalised bag of words representation


vocab_size = size(vocab, 2);

descriptors = sift_descriptor_extraction(img, sift_method, colorspace); 
bow = zeros(vocab_size, 1);

for d = 1:size(descriptors,2)
    [~, best_cluster] = min(vl_alldist(double(im2single(descriptors(:,d))), double(vocab)));
    bow(best_cluster,1) = bow(best_cluster) + 1;
end


bow_norm = bow / norm(bow, 1); 

end