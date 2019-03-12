%% main file for hand-in

close all
clear all

% TODO: some prints to inform user whats happening

%% extract data for vocabulary

[vocab_building_imgs, ~] = load_data("train" , 1.0, false, 1, ["all"], true);


%% create vocabulary 

random_number = 26;
vocab = create_vocabulary(vocab_building_imgs, random_number);


%% extract data for training and testing

wanted_classes = ["airplane", "bird", "ship", "horse", "car"];

% change the following for different data selection
start_index = 1;
percentage_of_data = 1.0;
random_selection = false;
two_dimensional_pictures = true;

[train_im, train_label] = load_data("train" , percentage_of_data, random_selection, start_index, wanted_classes, two_dimensional_pictures);
[test_im, test_label] = load_data("test" , percentage_of_data, random_selection, start_index, wanted_classes, two_dimensional_pictures);


%% convert to bag of words

BoW_train_imgs = bag_of_words(train_im, vocab);
BoW_test_imgs = bag_of_words(test_im, vocab);


%% train model

model = train_model(BoW_train_imgs, train_label); % (EX. 1.1)


%% test model

accurracy = test_model(model, BoW_test_imgs, test_label); % (EX. 1.2)
disp("Accuracy is " + accurracy + "%");


%% bonus 1 
% (EX. 4.~)

% etc