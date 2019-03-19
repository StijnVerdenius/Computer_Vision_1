function model = train_model(bows, labels, class) % EX. 2.5
% trains a SVM model with bows representations. (NOT FINISHED)


disp("started training svms for class " + class);

% maximum of input for classes that are not class
max_others = round(numel(labels)/20);

% length of input for the svm
input_length = round(numel(labels)*(2/5));

% Create binary classes for each classifier
new_labels = zeros(input_length,1);

% counts how much we have of each class
counters = zeros(max(labels),1);

% new container for bows
new_bows = zeros(size(bows, 1), input_length);

% counts the index of the new labels and bow containers
index_counter = 1;

for i = 1:numel(labels) 
    
    % label = 1 if belonging to selected class, otherwise 0
    current_label = (labels(i) == class);
    
    % if not the class from input, see if we have too many of them already
    if ~(current_label)
        if (counters(labels(i)) >= max_others)
            continue
        end
        % if we don't, increase the counter
        counters(labels(i)) = counters(labels(i)) + 1;
    end
    
    % put in new container
    new_bows(:, index_counter) = bows(:, index_counter);
    new_labels(index_counter) = current_label;
    
    % increase index counter
    index_counter = index_counter + 1;
end


%train binary SVM 

% model = fitcsvm(double(bows.'), [new_labels],'ClassNames',[0 1],'KernelFunction','rbf');

model = train(double(new_labels), sparse(new_bows.'));


%this fits a score-to-posterior-probability transformation function to the scores
% model = fitSVMPosterior(compact(model),double(bows.'), [new_labels]);
 

end