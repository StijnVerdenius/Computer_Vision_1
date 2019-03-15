function models = train_models(bows, labels, classes)

disp("started training svms");

models = [];

for c = 1:length(classes)
    model = train_model(bows, labels, classes(c));
    models = [models; model];
end
    
disp("finished training svms");


end

