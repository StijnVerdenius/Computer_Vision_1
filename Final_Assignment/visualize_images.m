function [] = visualize_images(images, index)

% rows = class, column = image index
top5_set_idx = index(:, 1:5);
bottom5_set_idx = index(:,end-5:end);

classes = ["airplanes", "birds", "ships", "horses" , "cars"];

figure('NumberTitle', 'off', 'Name', 'Top 5 test images per setup');
class_idx = 1;
for i = 1:25
    subplot(5,5,i);
    image_idx = rem(i,5);
    if rem(i,5) == 0
        image_idx = 5;
    end
    imshow(images(:,:,:,top5_set_idx(class_idx,image_idx)));
    if image_idx ==1
        ylabel(classes{class_idx});
    end
    if rem(i,5) == 0
        class_idx = class_idx + 1;
    end
end


figure('NumberTitle', 'off', 'Name', 'Bottom 5 test images per setup');
class_idx = 1;
for i = 1:25
    subplot(5,5,i);
    image_idx = rem(i,5);
    if rem(i,5) == 0
        image_idx = 5;
    end
    imshow(images(:,:,:,bottom5_set_idx(class_idx,image_idx))); 
    if image_idx ==1
        ylabel(classes{class_idx});
    end    
    if rem(i,5) == 0
        class_idx = class_idx + 1;
    end
end

end

