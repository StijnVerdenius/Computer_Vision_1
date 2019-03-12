function [imgs, labels] = load_data(set, percentage_to_load, random, from_index, classes, reshaped)
% function loads data into images and labels



% IMPORTANT: put data in folder stl10_matlab

%input:
% - setname
% - percentage of pictures to load
% - random selection or not (boolean)
% - from index in case not random
% - which classes
% - reshaped (bool) if true then it returns it H x W x Ch x N, if false then it returns it N x (W*H*Ch)

% some input assertions  
assert (set == "train" || set == "test");
assert (from_index >= 1);
assert (percentage_to_load >= 0 && percentage_to_load <= 1);

% get file
raw = load("./Part_1/data/stl10_matlab/"+set+".mat");

% get rid of unwanted classes
trimmed = remove_unwanted_classes(raw, classes);

% find number of files
max = size(trimmed.y, 1);

% determine how many to select
amount_to_load = floor(percentage_to_load*max-1);

% assert thats not too little or too much
assert(amount_to_load > 0 && amount_to_load <= max);

%get indices
if (random) 
    indices = randi(max,amount_to_load,1);
else
    to_index = (from_index+amount_to_load);
    assert (to_index <= max);
    indices = from_index:to_index;
end

% select data from indices
trimmed.X = transpose(trimmed.X(indices, :));
if (reshaped)
    imgs = reshape(trimmed.X, 96, 96, 3, numel(indices));
else
    imgs = trimmed.X;
end
labels = trimmed.y(indices);

end

% todo: add id to images and labels so we can make sure they match?
