function acc = test_models(models, bows, labels) % EX. 2.6 --- is this the prefictor part?
% trains a SVM model with bows representations. (NOT FINISHED)

disp("started evaluating testset");

for m = length(models)
%     model = fitPosterior(models{m},double(bows.'), labels); %this fits a score-to-posterior-probability transformation function to the scores
    [label, mAP] = predict(models{m},double(bows.'));
    
    scores = zeros(length(labels),1);
    for i = length(labels)
        score = strcmp(labels(i),label);
        scores(i) = score;
    end
    acc = sum(scores)/length(models);
end
% TODO: entire function
   
    



acc =0;

disp("finished evaluating testset");

end