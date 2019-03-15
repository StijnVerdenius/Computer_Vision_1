function MAP = test_models(models, bows, labels, classes) % EX. 2.6 --- is this the prefictor part?
% trains a SVM model with bows representations. (NOT FINISHED)

disp("started evaluating testset");

%Average Precisions
AP = zeros(length(models),1);

for m = length(models)
%     model = fitPosterior(models{m},double(bows.'), labels); %this fits a score-to-posterior-probability transformation function to the scores
    [label, posterior] = predict(models{m},double(bows.'));
    
    score = 0;
    
    for i = length(labels)
        score = score + strcmp(labels(i),label)/i;
    end
    
    AP(m) = score/sum(labels(:) == classes(m));
    
end
% TODO: entire function
   
%Mean Average Precision
MAP = mean(AP); 


% acc =0;

disp("finished evaluating testset");

end