%% main file for hand-in

% prepare setup
close all
clear all
vl_setup()


%% extract data for vocabulary

[vocab_building_imgs, ~] = load_image_data("train" , 0.05, false, 1, ["all"], true);


%% create vocabulary

random_number = 50; % According to assignment either 400, 1000 or 4000
loading_if_possible = true;
saving_when_done = true;
vocab = create_vocabulary(vocab_building_imgs, random_number, loading_if_possible, saving_when_done);


%% extract data for training and testing

wanted_classes = ["airplane", "bird", "ship", "horse", "car"];

% change the following for different data selection
start_index = 1;
percentage_of_data = 0.05;
random_selection = false;
two_dimensional_pictures = true;

[train_im, train_label] = load_image_data("train" , percentage_of_data, random_selection, start_index, wanted_classes, two_dimensional_pictures);
[test_im, test_label] = load_image_data("test" , percentage_of_data, random_selection, start_index, wanted_classes, two_dimensional_pictures);


%% convert to bag of words

loading_if_possible = true;
saving_when_done = true;
BoW_train_imgs = bagging_images(train_im, vocab, loading_if_possible, saving_when_done, "train");
BoW_test_imgs = bagging_images(test_im, vocab, loading_if_possible, saving_when_done, "test");


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