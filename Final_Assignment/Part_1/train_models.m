function models = train_models(bows, labels, classes)

disp("started training svms");

models = cell(length(classes),1);

for c = 1:length(classes)
    models{c} = train_model(bows, labels, classes(c));
    
end
    
disp("finished training svms");


end

