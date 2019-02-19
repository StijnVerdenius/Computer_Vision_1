close all
clear all
clc
 
disp('Part 1: Photometric Stereo')

% obtain many images in a fixed view under different illumination
disp('Loading images...')

% Sphere gray
image_dir_5 = './photometrics_images/SphereGray5/';   % TODO: get the path of the script
image_dir_25 = './photometrics_images/SphereGray25/';   % TODO: get the path of the script

% SphereColor
image_dir_25_rgb = './photometrics_images/MonkeyColor/';   % TODO: get the path of the script

% RGB version of sphere
% photometric_stereo_rgb(image_dir_25_rgb,25, false);
% return;

%image_ext = '*.png';
% 5 Images
% [image_stack5, scriptV5] = load_face_images('./photometrics_images/yaleB02/');
% [h5, w5, n5] = size(image_stack5);
% fprintf('Finish loading %d images.\n\n', n5);
% 
% % compute the surface gradient from the stack of imgs and light source mat
% disp('Computing surface albedo and normal map...')
% [albedo5, normals5] = estimate_alb_nrm(image_stack5, scriptV5, false);
% [albedo5_trick, normals5_trick] = estimate_alb_nrm(image_stack5, scriptV5);
% 
% % 25 Images
% [image_stack25, scriptV25] = load_syn_images(image_dir_25, 25);
% [h25, w25, n25] = size(image_stack25);
% fprintf('Finish loading %d images.\n\n', n25);
% 
% % compute the surface gradient from the stack of imgs and light source mat
% disp('Computing surface albedo and normal map...')
% [albedo25, normals25] = estimate_alb_nrm(image_stack25, scriptV25, false);
% [albedo25_trick, normals25_trick] = estimate_alb_nrm(image_stack25, scriptV25);

% figure(1)
% subplot(2,2,1);
% imshow(albedo5);
% title("Albedo 5 no trick")
% subplot(2,2,2);
% imshow(albedo25);
% title("Albedo 25 no trick")
% subplot(2,2,3);
% imshow(albedo5_trick);
% title("Albedo 5 with trick")
% subplot(2,2,4);
% imshow(albedo25_trick);
% title("Albedo 25 with trick")
%% How many images do we need to estimate albedo?

% figure(2)
% i = 0;
% for num_images=(5:5:25)
% %      
%     [image_stack_i, scriptV_i] = load_syn_images(image_dir_25, num_images);
%     [albedo_i, normals_i] = estimate_alb_nrm(image_stack_i, scriptV_i, true);
% % %     
%     i = i + 1;
%     subplot(2, 5, i)
%     imshow(albedo_i)
%     title(num_images)
%     subplot(2, 5, i + 5)
%     imshow(normals_i)
%     title(num_images)
% end
% return;

%% integrability check: is (dp / dy  -  dq / dx) ^ 2 small everywhere?
% disp('Integrability checking')
% [p5, q5, SE5] = check_integrability(normals5_trick);
% [p25, q25, SE25] = check_integrability(normals25_trick);
% 
% threshold = 0.005;
% SE5(SE5 <= threshold) = NaN; % for good visualization
% SE25(SE25 <= threshold) = NaN; % for good visualization
% figure(3)
% subplot(1,2,1)
% imshow(SE5);
% title(sum(sum(SE5 > threshold)))
% subplot(1,2,2)
% imshow(SE25);
% title(sum(sum(SE25 > threshold)))

% display(size(SE))
%fprintf('Number of outliers SE5: %d\n\n', sum(sum(SE5 > threshold)));
% fprintf('Number of outliers SE25: %d\n\n', sum(sum(SE25 > threshold)));
% 
% %% compute the surface height
% height_map_avg = construct_surface( p5, q5, "average");
% height_map_row = construct_surface( p5, q5, "row");
% height_map_column = construct_surface( p5, q5, "column");
% 
% figure(1)
% subplot(1,3,1)
% imshow(height_map_row);
% title("height map row")
% 
% subplot(1,3,2)
% imshow(height_map_column);
% title("height map column")
% 
% subplot(1,3,3);
% imshow(height_map_avg);
% title("height map average")
% 
% return;
% 
% subplot(2,3,4)
% show_model(albedo5_trick, height_map_avg);
% title("model average")
% 
% subplot(2,3,5);
% show_model(albedo5_trick, height_map_column);
% title("model column")
% 
% subplot(2,3,6)
% show_model(albedo5_trick, height_map_row);
% title("model row")
% 
% return;
% 
% %% Display
% show_model(albedo5_trick, height_map_avg);
% return;
%
%% Face
%[image_stack, scriptV] = load_face_images('./photometrics_images/MonkeyGray/');
%image_dir = './photometrics_images/yaleB02/'
%load_face_images(image_dir)


% ------------ CHANGE DIR HERE -----------------
[image_stack, scriptV] = load_syn_images(image_dir_5, 5);
[h, w, n] = size(image_stack);
fprintf('Finish loading %d images.\n\n', n);
disp('Computing surface albedo and normal map...')
[albedo, normals] = estimate_alb_nrm(image_stack, scriptV);
[p, q, SE] = check_integrability(normals);
threshold = 0.005;
SE(SE <= threshold) = NaN; % for good visualization

height_map = construct_surface( p, q );
show_model(albedo, height_map);
show_results(albedo, normals, SE);

%% integrability check: is (dp / dy  -  dq / dx) ^ 2 small everywhere?
% disp('Integrability checking')
% [p, q, SE] = check_integrability(normals);
% 
% threshold = 0.005;
% SE(SE <= threshold) = NaN; % for good visualization
% fprintf('Number of outliers: %d\n\n', sum(sum(SE > threshold)));

%% compute the surface height
% height_map_row = construct_surface( p, q,'row' );
% height_map_col = construct_surface( p, q,'column' );
% height_map_avg = construct_surface( p, q,'average' );
% [X,Y] = meshgrid(1:1:512,1:1:512);
% s = surf(X,Y,height_map);
% colormap;
% return;
% 
% show_results(albedo, normals, SE);
% show_model(albedo, height_map_row);
% show_model(albedo, height_map_col);
% show_model(albedo, height_map_avg);
