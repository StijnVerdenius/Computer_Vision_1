%% main file for hand-in

% prepare setup
close all
clear all
vl_setup()

%% extract data for vocabulary

[vocab_building_imgs, ~] = load_image_data("train" , 0.1, true, 1, ["all"], true); % get all classes from trainset to generate vocabulary


%% create vocabulary

vocabulary_size = 100;                    % According to assignment either 400, 1000 or 4000
loading_vocab_if_possible = false;          % defines whether vocabulary will be loaded from cache
saving_when_done = true;                   % defines whether it will be cached after generating, given its not loaded
vocab = create_vocabulary(vocab_building_imgs, vocabulary_size, loading_vocab_if_possible, saving_when_done); % creates vocabulary


%% extract data for training and testing

wanted_classes = ["airplane", "bird", "ship", "horse", "car"];

% change the following for different data selection
start_index = 1;                         % index from which to start loading data in cas of non random loading
percentage_of_data = 0.05;               % percentage of data loaded into model
random_selection = false;                % wether selection is random images
two_dimensional_pictures = true;         % load pictures into vectors or plottable images

[train_im, train_label] = load_image_data("train" , percentage_of_data, random_selection, start_index, wanted_classes, two_dimensional_pictures);
[test_im, test_label] = load_image_data("test" , percentage_of_data, random_selection, start_index, wanted_classes, two_dimensional_pictures);


%% convert to bag of words

loading_bow_if_possible = false;                           % same as before
saving_when_done = true;                                  % same as before
sift_method = "dense";                                 % = dense or keypoint
BoW_train_imgs = bagging_images(train_im, vocab, loading_bow_if_possible, saving_when_done, "train", sift_method); % transform images to BoW representation
BoW_test_imgs = bagging_images(test_im, vocab, loading_bow_if_possible, saving_when_done, "test", sift_method); % transform images to BoW representation

%% train models

classes = [1, 2, 9, 7, 3]; % ["airplanes", "birds", "ships", "horses" , "cars"]

models = train_models(BoW_train_imgs, train_label, classes); % (EX. 1.1)


%% test model

MAP = test_models(models, BoW_test_imgs, test_label, classes); % (EX. 1.2) MAP = mean average precision
% disp("Accuracy is " + accurracy + "%");
disp("Mean Average Precision is " + MAP);


%% bonus 1 
% (EX. 4.~)

% etc