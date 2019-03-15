function model = train_model(bows, labels, class) % EX. 2.5
% trains a SVM model with bows representations. (NOT FINISHED)

% TODO: entire function
% TODO: download and learn LIBLINEAR-SVM (see assignment)

disp("started training svms for class " + class);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% THIS IS IF WE USE LIBLINEAR

% % need to run 'make' in matlab console first (Directory = liblinear-2.21/matlab) 
% %----> May need to change the matlab directory in MATLABDIR in Makefile for this!!!!!

% make; 

% model = train(labels, bows[,'liblinear_options', 'col']); 

%This is the command given in the liblinear package

%         -labels:
%             An m by 1 vector of training labels. (type must be double)
%         -bows:
%             An m by n matrix of m training instances with n features.
%             It must be a sparse matrix. (type must be double)
%         -liblinear_options:
%             A string of training options in the same format as that of LIBLINEAR.
%         -col:
%             if 'col' is set, each column of training_instance_matrix is a data instance. Otherwise each row is a data instance.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SVM alternative below


% Create binary classes for each classifier
new_labels = zeros(length(labels),1);

for i = 1:numel(labels) 
    current_label = strcmp(labels(i),class); 
    new_labels(i) = current_label;
end

%train binary SVM 
model = fitcsvm(double(bows.'),[new_labels],'ClassNames',[false true],'Standardize',true,'KernelFunction','rbf','BoxConstraint',1);
model = fitPosterior(compact(model),double(bows.'), [new_labels]); %this fits a score-to-posterior-probability transformation function to the scores



%  model = fitcsvm(double(bows.'), labels, "ClassNames", class); % we need 5 of these, or not? - Yes -> airplanes, birds, ships, horses and car
 
 
% % bows — Matrix of predictor data, where each row is one observation, and each column is one predictor.
% 
% % labels — Array of class labels with each row corresponding to the value of the corresponding row in Bows.

 
 
%  disp("finished training svms");

end