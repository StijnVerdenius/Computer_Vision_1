function bow_imgs = bagging_images(imgs, vocab)
% converts many images to bag of words descriptor given a vocabulary (NOT FINISHED)

disp("started finding bag of words representations");

% TODO: choose right size-dimension as soon as vocab is implemented
vocab_size = size(vocab, 3);

batch_dimension = numel(size(imgs));
number_of_images = size(imgs, batch_dimension);
if (batch_dimension == 2)
    imgs = reshape(imgs, 96, 96, 3, number_of_images);
end

bow_imgs = zeros(vocab_size,number_of_images, 'int16');

for i = 1:number_of_images
    bow_imgs(:,i) = bag_of_words(imgs(i));
end

disp("finished finding bag of words representations");

end