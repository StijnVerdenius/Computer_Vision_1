function model = train_model(bows, labels, class) % EX. 2.5
% trains a SVM model with bows representations. (NOT FINISHED)

% TODO: entire function
% TODO: download and learn LIBLINEAR-SVM (see assignment)

% disp("started training svms");

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

% 
% model = fitcsvm(bows,labels,'KernelFunction','rbf','Standardize',true,'ClassNames',{'negClass','posClass'});
% % KernelFunction — The default value is 'linear' for two-class learning, which separates the data by a hyperplane. The value 'gaussian' (or 'rbf') is the default for one-class learning, and specifies to use the Gaussian (or radial basis function) kernel. 
% 
% % Standardize — Flag indicating whether we should standardize the predictors before training the classifier.
% 
% % ClassNames — Distinguishes between the negative and positive classes, or specifies which classes to include in the data. The negative class is the first element (or row of a character array), e.g., 'negClass', and the positive class is the second element (or row of a character array), e.g., 'posClass'. ClassNames must be the same data type as Y. 

 model = fitcsvm(double(bows.'), labels, "ClassNames", class); % we need 5 of these, or not? - Yes -> airplanes, birds, ships, horses and cars
 
% % bows — Matrix of predictor data, where each row is one observation, and each column is one predictor.
% 
% % labels — Array of class labels with each row corresponding to the value of the corresponding row in Bows.
% 
 
 
 disp("finished training svms");

end