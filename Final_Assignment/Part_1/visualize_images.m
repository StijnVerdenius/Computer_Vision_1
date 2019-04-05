function visualize_images(images, index, scores, sift_method, colorspace, vocabulary_size, AP, MAP, save_version)	 % DOCSTRING_GENERATED
 % VISUALIZE_IMAGES		 [visualizes images of run]
 % INPUTS 
 %			images = ..
 %			index = ..
 %			scores = ..
 %			sift_method = ..
 %			colorspace = ..
 %			vocabulary_size = ..
 %			AP = ..
 %			MAP = ..
 %			save_version = ..
 % OUTPUTS 



% rows = class, column = image index
top5_set_idx = index(:, 1:5);
bottom5_set_idx = index(:,end-5:end);

classes = ["airplanes", "birds", "ships", "horses" , "cars"];

top5 = figure('NumberTitle', 'off', 'Name', 'Top 5 test images per setup (' + sift_method + ', ' + colorspace + ', mAP = ' + MAP + ')');

class_idx = 1;
for i = 1:25
    subplot(5,5,i);
    image_idx = rem(i,5);
    if rem(i,5) == 0
        image_idx = 5;
    end
    imshow(images(:,:,:,top5_set_idx(class_idx,image_idx)));
%     title(round(scores(class_idx, image_idx),3)) %this is for the scores as image titles
    if image_idx ==1
%         ylabel({classes{class_idx},"AP = " + round(AP(class_idx),3)}); %remove AP when done
        ylabel(classes{class_idx}); %remove AP when done
    end
    if rem(i,5) == 0
        class_idx = class_idx + 1;
    end
end
% sgtitle('Top 5 (' + sift_method + ', ' + colorspace + ', ' + vocabulary_size + ')')

top5 = tightfig(top5);

saveas(gcf,get_path("results") + 'Top 5, ' + save_version + '.png');


bottom5 = figure('NumberTitle', 'off', 'Name', 'Bottom 5 test images per setup (' + sift_method + ', ' + colorspace + ', mAP = ' + MAP + ', k = ' +  vocabulary_size + ')');

class_idx = 1;
for i = 1:25
    subplot(5,5,i);
    image_idx = rem(i,5);
    if rem(i,5) == 0
        image_idx = 5;
    end
    imshow(images(:,:,:,bottom5_set_idx(class_idx,image_idx))); 
%     title(round(scores(class_idx, end-(5-image_idx)),3)) %this is for the scores as image titles
    if image_idx ==1
%         ylabel({classes{class_idx},"AP = " + round(AP(class_idx),3)}); %remove AP when done
        ylabel(classes{class_idx}); %remove AP when done
    end    
    if rem(i,5) == 0
        class_idx = class_idx + 1;
    end
end
% sgtitle('Bottom 5 (' + sift_method + ', ' + colorspace + ', '+ vocabulary_size + ')')

bottom5 = tightfig(bottom5);
saveas(bottom5, get_path("results") + 'Bottom 5, ' + save_version + '.png');


end

