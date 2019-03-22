function trimmed = remove_unwanted_classes(raw, classes)	 % DOCSTRING_GENERATED
 % REMOVE_UNWANTED_CLASSES		 [function removes unwanted classes from dataset]
 % INPUTS 
 %			raw = data struct with all classes
 %			classes = classes list you want to keep (string) 
 % OUTPUTS 
 %			trimmed = data struct with less classes


number_of_classes = numel(classes);

% if all clases are required, just return input
if ( (number_of_classes == 10) || ismember("all", classes) )
    trimmed = raw;
else
    % otherwise, remove classes that are not specified
    
    max = size(raw.y, 1);
    
    % will be used as a lookup table to say "this image should or shouldn't be used"
    boolean_indices = zeros(max, 1); 
    
    class_indices = zeros(number_of_classes, 1);
    
    % get class indices
    for i = 1:number_of_classes
        class_index = find(raw.class_names==classes(i));
        class_indices(i) = class_index;
    end
    
    % see which images should stay
    for i = 1:max
        if(ismember(raw.y(i), class_indices))
            boolean_indices(i) = 1;
        end
    end
    
    trimmed = raw;
    actual_indices = find(boolean_indices==1); % transform to actual indices
    
    % apply selection
    trimmed.X = trimmed.X(actual_indices, :);
    trimmed.y = trimmed.y(actual_indices);
end
end