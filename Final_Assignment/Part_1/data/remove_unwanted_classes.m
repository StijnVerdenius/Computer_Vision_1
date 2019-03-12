function trimmed = remove_unwanted_classes(raw, classes)
% function removes unwanted classes from dataset

max = size(raw.y, 1);
boolean_indices = zeros(max, 1);

number_of_classes = numel(classes);
class_indices = zeros(number_of_classes, 1);

for i = 1:number_of_classes
    class_index = find(raw.class_names==classes(i));
    class_indices(i) = class_index;
end

for i = 1:max
    if(ismember(raw.y(i), class_indices))
        boolean_indices(i) = 1;
    end
end

trimmed = raw;
actual_indices = find(boolean_indices==1);
trimmed.X = trimmed.X(actual_indices, :);
trimmed.y = trimmed.y(actual_indices);
end