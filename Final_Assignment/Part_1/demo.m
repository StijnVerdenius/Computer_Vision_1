%% main file for hand-in

% prepare setup
close all
clear all
vl_setup()

%% extract data for vocabulary

[vocab_building_imgs, ~] = load_image_data("train" , 1.0, true, 1, ["all"], true); % get all classes from trainset to generate vocabulary


%% create vocabulary

vocabulary_size = 400;                    % According to assignment either 400, 1000 or 4000
loading_vocab_if_possible = false;          % defines whether vocabulary will be loaded from cache
saving_when_done = true;                   % defines whether it will be cached after generating, given its not loaded
cache_version_vocab = "400-rgb";
apply_sampling = true;
number_of_samples = 10^6;
colorspace = "rgb";

vocab = create_vocabulary(vocab_building_imgs, vocabulary_size, loading_vocab_if_possible, saving_when_done, cache_version_vocab, apply_sampling, number_of_samples, colorspace); % creates vocabulary


%% extract data for training and testing

wanted_classes = ["airplane", "bird", "ship", "horse", "car"];

% change the following for different data selection
start_index = 1;                         % index from which to start loading data in cas of non random loading
percentage_of_data = 0.5;               % percentage of data loaded into model
random_selection = false;                % wether selection is random images
two_dimensional_pictures = true;         % load pictures into vectors or plottable images

[train_im, train_label] = load_image_data("train" , percentage_of_data, random_selection, start_index, wanted_classes, two_dimensional_pictures);
[test_im, test_label] = load_image_data("test" , percentage_of_data, random_selection, start_index, wanted_classes, two_dimensional_pictures);


%% convert to bag of words

loading_bow_if_possible = false;                           % same as before
saving_when_done = true;                                  % same as before
cache_version_bow = "400-rgb";
sift_method = "dense";                                 % = dense or keypoint
BoW_train_imgs = bagging_images(train_im, vocab, loading_bow_if_possible, saving_when_done, "train", sift_method, cache_version_bow, colorspace); % transform images to BoW representation
BoW_test_imgs = bagging_images(test_im, vocab, loading_bow_if_possible, saving_when_done, "test", sift_method, cache_version_bow, colorspace); % transform images to BoW representation

%% train models

classes = [1, 2, 9, 7, 3]; % ["airplanes", "birds", "ships", "horses" , "cars"]
 % (EX. 1.2) MAP = mean average precision
% % disp("Accuracy is " + accurracy + "%");



models = train_models(BoW_train_imgs, train_label, classes); % (EX. 1.1)


%% test model

[AP, MAP, scores, best_image_index] = test_models(models, BoW_test_imgs, test_label, classes);

disp("Mean Average Precision is (us) " + MAP);
MAP = victor_train_test(BoW_train_imgs, train_label, BoW_test_imgs, test_label, classes);
disp("Mean Average Precision is (victor) " + MAP);

% visualize_images(test_im, best_image_index, scores, sift_method, colorspace, vocabulary_size, AP, MAP); %Need to edit this to add setup to titles specifications (SIFT sampling variants, vocabulary size, SIFT color variants)

%% bonus 1 
% (EX. 4.~)

% etc