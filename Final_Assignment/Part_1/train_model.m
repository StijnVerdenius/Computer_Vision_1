function model = train_model(bows, labels, class) % EX. 2.5
% trains a SVM model with bows representations. (NOT FINISHED)


disp("started training svms for class " + class);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Stijn ordering
% % maximum of input for classes that are not class
% max_others = round(numel(labels)/20);
% 
% % length of input for the svm
% input_length = round(numel(labels)*(2/5));
% 
% % Create binary classes for each classifier
% new_labels = zeros(input_length,1);
% 
% % counts how much we have of each class
% counters = zeros(max(labels),1);
% 
% % new container for bows
% new_bows = zeros(size(bows, 1), input_length);
% 
% % counts the index of the new labels and bow containers
% index_counter = 1;
% 
% for i = 1:numel(labels) 
%     
%     % label = 1 if belonging to selected class, otherwise 0
%     current_label = (labels(i) == class);
%     
%     % if not the class from input, see if we have too many of them already
%     if ~(current_label)
%         if (counters(labels(i)) >= max_others)
%             continue
%         end
%         % if we don't, increase the counter
%         counters(labels(i)) = counters(labels(i)) + 1;
%     end
%     
%     % put in new container
%     new_bows(:, index_counter) = bows(:, index_counter);
%     new_labels(index_counter) = current_label;
%     
%     % increase index counter
%     index_counter = index_counter + 1;
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Elias
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ordering
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% below!


all_classes = [1, 2, 9, 7, 3];

other_classes = all_classes(all_classes ~= class);

train_set = zeros(numel(bows(:,1)),1000);

%get 125 negative example images per class 
for c = 1:numel(other_classes)
    %find index of images in bows from class c
    idx = find(labels == other_classes(c));
    %get 125 random images from class c
    permutations = randperm(numel(idx));
    subset = idx(permutations(1:125));
    %get indices
    h = c*125;
    l = h-124;
    %add to the training set
    train_set(:,l:h) = bows(:,subset);
end    


%get 500 positive example images
idx = find(labels == class);
permutations = randperm(numel(idx));
subset = idx(permutations(1:500));
%add to the training set
train_set(:,h+1:1000) = bows(:,subset);


% %Create binary classes for each classifier
lab_0 = zeros(500,1);
lab_1 = ones(500,1);
new_labels = cat(1,lab_0,lab_1);


% Arrange training set randomly
permutations = randperm(1000);
train_set = train_set(:, permutations);
new_labels = new_labels(permutations);


% % Create binary classes for each classifier
% new_labels = zeros(length(labels),1);
% 
% % label = 1 if belonging to selected class, otherwise 0
% for i = 1:numel(labels) 
% %     current_label = strcmp(string(labels(i)),string(class)); 
%     current_label = labels(i) == class; 
%     new_labels(i) = current_label;
% end



%train binary SVM 

model = fitcsvm(double(train_set.'), new_labels,'ClassNames',[0 1],'KernelFunction','rbf', 'Cost',[0 1;4 0]);

% model = train(double(new_labels), sparse(train_set.'));

% model = fitcsvm(double(new_bows.'), [new_labels],'ClassNames',[0 1],'KernelFunction','rbf', 'Cost',[0 1;4 0]);

% model = train(double(new_labels), sparse(new_bows.'));



%this fits a score-to-posterior-probability transformation function to the scores
% model = fitSVMPosterior(compact(model),double(bows.'), [new_labels]);
 

end