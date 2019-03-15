function MAP = test_models(models, bows, labels, classes) % EX. 2.6 --- is this the prefictor part?
% trains a SVM model with bows representations. (NOT FINISHED)

disp("started evaluating testset");

%Average Precisions
AP = zeros(length(models),1);
classification_score = zeros(length(models), size(bows, 2));


for m = length(models)
    
    %labels are 1 if our binary SVM decides they belong to the trained
    %class and 0 otherwise
    [label, posterior] = predict(models{m},double(bows.'));

    % replace labels that are 1 to the class of the model (class trained
    % on)
    label(label == 1) = classes(m);
    
    %matix - rows = model, columns = image scores from selected model
    classification_score(m,:) = posterior(:,2).';
    
    
    %get sorted images and keep track of index
    [sorted_classification_score , index ] = sort(classification_score(m),'ascend');
    
    
    score = 0;
    
    for i = length(labels)
        % + 1 if predicted label matches actual label
        score = score + strcmp(string(labels(i)),string(label(i)))/i;
    end
    
    
    AP(m) = score/sum(labels(:) == classes(m));
    
end

   
%Mean Average Precision
MAP = mean(AP); 











% acc =0;

disp("finished evaluating testset");

end