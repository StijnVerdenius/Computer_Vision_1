%% main file for hand-in

close all
clear all

%% extract data for vocabulary

[vocab_building_imgs, ~] = load_data("train" , 1.0, false, 1, ["all"], true);


%% create vocabulary 

random_number = 26;
vocab = create_vocabulary(vocab_building_imgs, random_number);


%% extract data for training and testing

[train_im, train_label] = load_data("train" , 1.0, false, 1, ["airplane", "bird", "ship", "horse", "car"], true);
[test_im, test_label] = load_data("test" , 1.0, false, 1, ["airplane", "bird", "ship", "horse", "car"], true);


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