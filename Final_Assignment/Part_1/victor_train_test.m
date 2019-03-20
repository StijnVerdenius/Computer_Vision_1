function MAP = victor_train_test(x_svm_BoW, y_svm, x_test_BoW, y_test, classes) %initialize variables for lower run time.



SVMModels = cell(1,5);
label = cell(1,5);
score = cell(1,5);
sorted_imgs = cell(1,5);
sorted_labels = cell(1,5);
average_precisions = zeros(1,5);

%train one model for each class
for i =1:length(classes)
    
    
    %binary label for the class
    y = y_svm == classes(i);
    
    %train the SVM
    SVMModels{i} = fitcsvm(x_svm_BoW.', y, 'KernelFunction', 'rbf', 'Cost', [0,1;4,0]);
    
    %get results of the model on the test set
    [label{i}, score{i}] = predict(SVMModels{i}, x_test_BoW.');
    
    %sorts images and labels by their scores to this class
    [~, idx] = sort(score{i}(:,1));
%     sorted_imgs{i} = x_test(idx);
    sorted_labels{i} = y_test(idx);
    
    %calculates Average Precision for the classifier
    binary_labels = sorted_labels{i} == classes(i);
    cumulative = cumsum(binary_labels);
    precisions = cumulative .* binary_labels ./ (1:length(sorted_labels{i}))';
    average_precisions(i) = sum(precisions)/sum(binary_labels);
    
%     %display and save top 5 images
%     figure(i)
%     top_im = [sorted_imgs{i}{1}, sorted_imgs{i}{2}, sorted_imgs{i}{3}, sorted_imgs{i}{4}, sorted_imgs{i}{5}];
%     imshow(top_im)
%     name = path + "top5_class_" + num2str(class_name(i)) + "_"  + experiment_name + ".png";
%     export_fig(name);
%     
%     %display and save bottom 5 images.
%     figure(i+5)
%     bottom_im = [sorted_imgs{i}{end}, sorted_imgs{i}{end - 1}, sorted_imgs{i}{end - 2}, sorted_imgs{i}{end - 3}, sorted_imgs{i}{end - 4}];
%     imshow(bottom_im)
%     name = path + "bottom5_class_" + num2str(class_name(i))  + "_" + experiment_name + ".png";
%     export_fig(name);
end

%MAP over all classifiers
MAP = mean(average_precisions);