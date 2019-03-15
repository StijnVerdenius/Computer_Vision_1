%% main file for hand-in

% prepare setup
close all
clear all
vl_setup()


%% extract data for vocabulary

[vocab_building_imgs, ~] = load_image_data("train" , 0.5, false, 1, ["all"], true); % get all classes from trainset to generate vocabulary


%% create vocabulary

random_number = 50; % According to assignment either 400, 1000 or 4000
loading_if_possible = true; % defines whether vocabulary will be loaded from cache 
saving_when_done = true; % defines whether it will be cached after generating, given its not loaded
vocab = create_vocabulary(vocab_building_imgs, random_number, loading_if_possible, saving_when_done); % creates vocabulary


%% extract data for training and testing

wanted_classes = ["airplane", "bird", "ship", "horse", "car"];

% change the following for different data selection
start_index = 1; % index from which to start loading data in cas of non random loading
percentage_of_data = 0.05; % percentage of data loaded into model
random_selection = false; % wether selection is random images
two_dimensional_pictures = true; % load pictures into vectors or plottable images

[train_im, train_label] = load_image_data("train" , percentage_of_data, random_selection, start_index, wanted_classes, two_dimensional_pictures);
[test_im, test_label] = load_image_data("test" , percentage_of_data, random_selection, start_index, wanted_classes, two_dimensional_pictures);


%% convert to bag of words

loading_if_possible = true; % same as before
saving_when_done = true; % same as before
BoW_train_imgs = bagging_images(train_im, vocab, loading_if_possible, saving_when_done, "train"); % transform images to BoW representation
BoW_test_imgs = bagging_images(test_im, vocab, loading_if_possible, saving_when_done, "test"); % transform images to BoW representation


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