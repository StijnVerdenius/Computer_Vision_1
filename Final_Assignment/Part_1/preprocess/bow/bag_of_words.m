function bow = bag_of_words(img, vocab)
% converts one image to bag of words descriptor given a vocabulary (NOT FINISHED)

% TODO: choose right size-dimension as soon as vocab is implemented
vocab_size = size(vocab, 3);

descriptors = get_descriptors([img]);
bow = zeros(vocab_size, 1);

% TODO: match descriptors against vocab and then count (EX. 2.3). Subsequently,
% return bag of words frequencies for image (EX. 2.4)

end