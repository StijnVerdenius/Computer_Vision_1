function acc = test_model(model, imgs, labels) % EX. 2.6 --- is this the prefictor part?
% trains a SVM model with bows representations. (NOT FINISHED)

disp("started evaluating testset");

for elm = classes
    SVMmodel = fitPosterior(model,X,Y); %this fits a score-to-posterior-probability transformation function to the scores
    [label,score] = predict(SVMModel,newX);

% TODO: entire function
acc =0;

disp("finished evaluating testset");

end