function visualize(input_image)
% visualizes a image and its channels

% calculate subplot sizes
input_size = size(input_image);
number_of_channels =  input_size(end);
number_of_plots = number_of_channels + 1;
per_axis = ceil(sqrt(number_of_plots));

% plot imput image 
% unfortunatly there is no support for a fourth channel so we assume 3
subplot(per_axis, per_axis, 1)
imshow(input_image(:,:,1:3))

% plot seperate channels
for i=1:number_of_channels
    subplot(per_axis, per_axis, 1+i)
    imshow(input_image(:,:,i))
end

end

