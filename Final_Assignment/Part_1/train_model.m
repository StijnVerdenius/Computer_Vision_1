function model = train_model(bows, labels, class) % EX. 2.5
% trains a SVM model with bows representations. (NOT FINISHED)


disp("started training svms for class " + class);



% Create binary classes for each classifier
new_labels = zeros(length(labels),1);

% label = 1 if belonging to selected class, otherwise 0
for i = 1:numel(labels) 
    current_label = strcmp(string(labels(i)),string(class)); 
    new_labels(i) = current_label;
end


%train binary SVM 
% model = fitcsvm(double(bows.'),[new_labels],'ClassNames',[false true],'Standardize',true,'KernelFunction','rbf','BoxConstraint',1);
model = fitcsvm(double(bows.'),[new_labels]);

%this fits a score-to-posterior-probability transformation function to the scores
% model = fitSVMPosterior(compact(model),double(bows.'), [new_labels]);


% bows — Matrix of predictor data, where each row is one observation, and each column is one predictor.
 
% labels — Array of class labels with each row corresponding to the value of the corresponding row in Bows.

 
 
%  disp("finished training svms");

end