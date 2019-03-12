% Main script for final assignment

close all
clear all


[train_im, train_label] = load_data("train" , 1.0, false, 1, ["airplane", "bird", "ship", "horse", "car"], true);
[test_im, test_label] = load_data("test" , 1.0, false, 1, ["airplane", "bird", "ship", "horse", "car"], true);

model = train_model(train_im, train_label);

accurracy = test_model(model, test_im, test_label);

disp("Accuracy is " + accurracy + "%");