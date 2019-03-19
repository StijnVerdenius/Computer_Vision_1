function models = train_models(bows, labels, classes)

disp("started training svms");

%Stacking models in a cell
models = cell(numel(classes),1);

%loop through classes and train corresponding models 
for c = 1:numel(classes)
    models{c} = train_model(bows, labels, classes(c));
    
end
    
disp("finished training svms");


end

