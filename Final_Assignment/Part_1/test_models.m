function [MA, AP, MAP, sorted_classification_score, index] = test_models(models, bows, actual_labels, classes) % EX. 2.6 --- is this the prefictor part?
% trains a SVM model with bows representations. (NOT FINISHED)

disp("started evaluating testset");


%Average Precisions
AP = zeros(length(models),1);
Accuracy = zeros(length(models),1);
classification_score = zeros(length(models), size(bows, 2));
pred_labels = zeros(length(models), numel(actual_labels));

for m = 1:numel(models)
    
    %labels are 1 if our binary SVM decides they belong to the trained
    %class and 0 otherwise
    
    [pred_label, posterior] = predict(models{m},double(bows.'));
%     [pred_label, accuracy, posterior] = predict(double(actual_labels), sparse(bows.'), models{m});
    
    % replace labels that are 1 to the class of the model (class trained
    % on)
    
    pred_label(pred_label == 1) = classes(m);
    pred_labels(m,:) = pred_label.';
    
    %matix - rows = model, columns = image scores from selected model
    
    classification_score(m,:) = posterior(:,2).';
%     classification_score(m,:) = -posterior.';
    
%     %Average Precision calculations
%     score = 0;
%     cumulative = 0;
%     
%     for i = 1:numel(actual_labels)
%         % 1 if predicted label matches actual label or 0 otherwise
%         x_i = actual_labels(i) == pred_label(i);
%         cumulative = cumulative + x_i;
%         f_c = x_i * cumulative;
%         score = score + (f_c)/i;
%     end
%  
%     AP(m) = score/sum(actual_labels(:) == classes(m));
    
end

%get sorted images and keep track of index
[sorted_classification_score , index ] = sort(classification_score, 2 , 'descend');

%Average Precision calculations
for m = 1:numel(models)
    sorted_labels = actual_labels(index(m,:));
    score = 0;
    cumulative = 0;
    c_acc = 0;
    
    for i = 1:numel(actual_labels)
        % 1 if predicted label matches actual label or 0 otherwise
        acc = actual_labels(i) == pred_labels(m,i);
        c_acc = c_acc + acc;
        % 1 if ranked list class mathches classifier class
        x_i = sorted_labels(i) == classes(m);
        cumulative = cumulative + x_i;
        f_c = x_i * cumulative;
        score = score + (f_c)/i;
    end
    Accuracy(m) = c_acc/sum(actual_labels(:) == classes(m));
    AP(m) = score/sum(actual_labels(:) == classes(m));
end


%Mean Average Precision
MAP = mean(AP); 

%Mean Accuracy
MA = mean(Accuracy);


%Table displaying results
Classifier = {"airplane"; "bird"; "ship"; "horse"; "car"};
Accuracy = [Accuracy(1);Accuracy(2);Accuracy(3);Accuracy(4);Accuracy(5)];
Average_Precision = [AP(1);AP(2);AP(3);AP(4);AP(5)];

T = table(Classifier, Average_Precision, Accuracy)

disp("finished evaluating testset");    
    
    
end