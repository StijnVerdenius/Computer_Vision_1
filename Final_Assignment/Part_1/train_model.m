function model = train_model(bows, labels, class) % EX. 2.5
% trains a SVM model with bows representations. (NOT FINISHED)


disp("started training svms for class " + class);


% Create binary classes for each classifier
new_labels = zeros(numel(labels),1);

% label = 1 if belonging to selected class, otherwise 0
for i = 1:numel(labels) 
    current_label = labels(i) == class; 
    new_labels(i) = current_label;
end


%train binary SVM 

% model = fitcsvm(double(bows.'), [new_labels],'ClassNames',[0 1],'KernelFunction','rbf');

model = train(double(new_labels), sparse(bows.'));


%this fits a score-to-posterior-probability transformation function to the scores
% model = fitSVMPosterior(compact(model),double(bows.'), [new_labels]);
 

end