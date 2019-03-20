%% SAVED JUST IN CASE !!


% function [x_svm_BoW, x_test_BoW] = victor_preprocess()
% 
% %% !! not working for us yet, still have to attach
% 
% sampling_mode = "dense";
% sift_type = "RGB";
% feature_type = "sift";
% vocab_size = 400;
% clust_type = "kmeans";
% 
% classes = [1, 2, 9, 7, 3]; % ["airplanes", "birds", "ships", "horses" , "cars"]
% 
% im_dim = [96,96,3];
% 
% train_path = get_path("raw_data")+"train.mat";
% test_path = get_path("raw_data")+"train.mat";
% 
% split_rate = 0.5;
% 
% %magic function that loads the images and reshapes them
% [x_train, y_train] = load_n_reshape(train_path, classes, im_dim);
% [x_test, ~] = load_n_reshape(test_path, classes, im_dim);
% 
% [x_vocab, x_svm, ~, ~] = split_data(x_train, y_train, split_rate, classes);
% 
% vocabulary = create_vocabulary_2(x_vocab, sampling_mode, sift_type, vocab_size, feature_type, clust_type);
% 
% x_svm_BoW = BoW_representation_2(x_svm, sampling_mode, sift_type, feature_type, vocabulary, false);
% 
% x_test_BoW = BoW_representation_2(x_test, sampling_mode, sift_type, feature_type, vocabulary, false);
% 
% end
