function model = train_model(bows, labels, class) % EX. 2.5	 % DOCSTRING_GENERATED
 % TRAIN_MODEL		 [trains a SVM model with bows representations.]
 % INPUTS 
 %			bows = bag of words representations of images
 %			labels = corresponding labels
 %			class = true class for output model
 % OUTPUTS 
 %			model = self explanatory

disp("started training svms for class " + class);

%get training-set size - needs to be divisible by 8
size = find(labels == class);
size = numel(size);
while rem(size, 8) ~= 0
    size = size - 1;
end

size = size/8;

all_classes = [1, 2, 9, 7, 3];

other_classes = all_classes(all_classes ~= class);

train_set = zeros(numel(bows(:,1)),(size*8));

%get negative example images per class 
for c = 1:numel(other_classes)
    
    %find index of images in bows from class c
    idx = find(labels == other_classes(c));
    
    %get random images from class c
    permutations = randperm(numel(idx));
    subset = idx(permutations(1:size));
    
    %get indices
    h = c*size;
    l = h-size+1;
    
    %add to the training set
    train_set(:,l:h) = bows(:,subset);
    
end    

% get positive example images
idx = find(labels == class);
permutations = randperm(numel(idx));
subset = idx(permutations(1:(size*4)));
%add to the training set
train_set(:,h+1:(size*8)) = bows(:,subset);

% Create binary classes for each classifier
lab_0 = zeros((size*4),1);
lab_1 = ones((size*4),1);
new_labels = cat(1,lab_0,lab_1);

% Arrange training set randomly
permutations = randperm(size*8);
train_set = train_set(:, permutations);
new_labels = new_labels(permutations);

%train binary SVM 
model = fitcsvm(double(train_set.'), new_labels,'ClassNames',[0 1],'KernelFunction','rbf', 'Cost',[0 5;4 0]);

end