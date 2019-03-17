function [] = visualize_images(images, index, scores, sift_method, AP, MAP)

% rows = class, column = image index
top5_set_idx = index(:, 1:5);
bottom5_set_idx = index(:,end-5:end);

classes = ["airplanes", "birds", "ships", "horses" , "cars"];

figure('NumberTitle', 'off', 'Name', 'Top 5 test images per setup (' + sift_method + ', mAP = ' + MAP + ')');

class_idx = 1;
for i = 1:25
    subplot(5,5,i);
    image_idx = rem(i,5);
    if rem(i,5) == 0
        image_idx = 5;
    end
    imshow(images(:,:,:,top5_set_idx(class_idx,image_idx)));
    title(round(scores(class_idx, image_idx),3)) %this is for the scores as image titles
    if image_idx ==1
        ylabel({classes{class_idx},"AP = " + round(AP(class_idx),3)}); %remove AP when done
    end
    if rem(i,5) == 0
        class_idx = class_idx + 1;
    end
end


figure('NumberTitle', 'off', 'Name', 'Bottom 5 test images per setup (' + sift_method + ', mAP = ' + MAP + ')');

class_idx = 1;
for i = 1:25
    subplot(5,5,i);
    image_idx = rem(i,5);
    if rem(i,5) == 0
        image_idx = 5;
    end
    imshow(images(:,:,:,bottom5_set_idx(class_idx,image_idx))); 
    title(round(scores(class_idx, end-(5-image_idx)),3)) %this is for the scores as image titles
    if image_idx ==1
        ylabel({classes{class_idx},"AP = " + round(AP(class_idx),3)});
    end    
    if rem(i,5) == 0
        class_idx = class_idx + 1;
    end
end

end

