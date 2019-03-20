%% main file for hand-in

% prepare setup
close all
clear all
vl_setup()

%% extract data for vocabulary

% determines the percentage of training data used for vocabulary creation
percentage_vocab = 1.0;

% get all classes from trainset to generate vocabulary
[vocab_building_imgs, ~] = load_image_data("train" , percentage_vocab, true, 1, ["all"], true); 


%% create vocabulary

% VARIABLES TO SET
vocabulary_size = 400;											% either 400, 1000 or 4000
loading_vocab_if_possible = true;								% defines whether vocabulary will be loaded from cache
saving_when_done = true;										% defines whether it will be cached after generating, given its not loaded
apply_sampling = true;											% apply sampling of descriptors before entering k means
number_of_samples = 5*10^5;										% if you do sampling, how many?
colorspace = "opponent";										% define the to be used color space	

% automatically deduce cache version
cache_version_vocab = colorspace + "_" + vocabulary_size;

% create vocabular
vocab = create_vocabulary(vocab_building_imgs, vocabulary_size, loading_vocab_if_possible, saving_when_done, cache_version_vocab, apply_sampling, number_of_samples, colorspace); % creates vocabulary


%% extract data for training and testing

% VARIABLES TO SET
wanted_classes = ["airplane", "bird", "ship", "horse", "car"]; 	% which classes to use
start_index = 1;                         						% index from which to start loading data in cas of non random loading
percentage_of_data = 1.00;               						% percentage of data loaded into model
random_selection = false;                						% wether selection is random images
two_dimensional_pictures = true;        						% load pictures into vectors or plottable images

% get data
[train_im, train_label] = load_image_data("train" , percentage_of_data, random_selection, start_index, wanted_classes, two_dimensional_pictures);
[test_im, test_label] = load_image_data("test" , percentage_of_data, random_selection, start_index, wanted_classes, two_dimensional_pictures);


%% convert to bag of words

loading_bow_if_possible = true;                           		% defines whether vocabulary will be loaded from cache
saving_when_done = true;                                  		% defines whether it will be cached after generating, given its not loaded
sift_method = "keypoint";                                 		% either dense or keypoint

% automatically deduce cache version
cache_version_bow = sift_method + "_" + colorspace + "_" + vocabulary_size; 

% transform data to Bag of Words representations
BoW_train_imgs = bagging_images(train_im, vocab, loading_bow_if_possible, saving_when_done, "train", sift_method, cache_version_bow, colorspace); % transform images to BoW representation
BoW_test_imgs = bagging_images(test_im, vocab, loading_bow_if_possible, saving_when_done, "test", sift_method, cache_version_bow, colorspace); % transform images to BoW representation


%% train models

classes = [1, 2, 9, 7, 3]; % = ["airplanes", "birds", "ships", "horses" , "cars"] 
models = train_models(BoW_train_imgs, train_label, classes); 


%% test model

% automatically deduce cache version
cache_version_result = sift_method + "_" + colorspace + "_" + vocabulary_size; 

% test models
[MA, AP, MAP, scores, best_image_index] = test_models(models, BoW_test_imgs, test_label, classes, cache_version_result);

disp("Mean Average Precision = " + MAP + ", Mean Accuracy = " + MA);

% visualize and save
visualize_images(test_im, best_image_index, scores, sift_method, colorspace, vocabulary_size, AP, MAP, cache_version_result); %Need to edit this to add setup to titles specifications (SIFT sampling variants, vocabulary size, SIFT color variants)


%% END