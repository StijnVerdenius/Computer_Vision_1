function some_model = train_model(imgs, labels)

% convert to colour spaces
[gray_imgs, ~, opponent_imgs] = getColorSpaces(imgs);

figure(1)
imshow(opponent_imgs(:,:,:,3));
figure(2)
imshow(gray_imgs(:,:,:,3));

% todo

some_model = 0; % dummy

end