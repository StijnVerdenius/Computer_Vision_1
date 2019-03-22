function models = train_models(bows, labels, classes)	 % DOCSTRING_GENERATED
 % TRAIN_MODELS		 [Trains a svm model for each class]
 % INPUTS 
 %			bows = bag of words representations of images
 %			labels = corresponding labels
 %			classes = classes in integers
 % OUTPUTS 
 %			models = trained models



disp("started training svms");

%Stacking models in a cell
models = cell(numel(classes),1);

%loop through classes and train corresponding models 
for c = 1:numel(classes)
    models{c} = train_model(bows, labels, classes(c));
    
end
    
disp("finished training svms");


end

