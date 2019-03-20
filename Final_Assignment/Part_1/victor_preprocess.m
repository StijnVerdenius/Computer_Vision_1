function [x_svm_BoW, x_test_BoW] = victor_preprocess(x_svm, x_test, x_vocab)

%% !! not working for us yet, still have to attach

sampling_mode = "dense";
sift_type = "RGB";
feature_type = "sift";
vocab_size = 400;
clust_type = "kmeans";

vocabulary = create_vocabulary_2(x_vocab, sampling_mode, sift_type, vocab_size, feature_type, clust_type);

x_svm_BoW = BoW_representation_2(x_svm, sampling_mode, sift_type, feature_type, vocabulary, false);

x_test_BoW = BoW_representation_2(x_test, sampling_mode, sift_type, feature_type, vocabulary, false);

end
