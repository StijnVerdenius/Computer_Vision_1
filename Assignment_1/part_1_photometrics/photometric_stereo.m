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
image_dir_25_rgb = './photometrics_images/SphereColor/';   % TODO: get the path of the script

% RGB version of sphere
% [image_stack25rgb_ch1, scriptV25rgb_ch1] = load_syn_images(image_dir_25_rgb, 25, 1);
% [image_stack25rgb_ch3, scriptV25rgb_ch2] = load_syn_images(image_dir_25_rgb, 25, 2);
% [image_stack25rgb_ch2, scriptV25rgb_ch3] = load_syn_images(image_dir_25_rgb, 25, 3);
% 
% 
% [albedo25_ch1, normals25_ch1] = estimate_alb_nrm(image_stack25rgb_ch1, scriptV25rgb_ch1, false);
% [albedo25_ch2, normals25_ch2] = estimate_alb_nrm(image_stack25rgb_ch2, scriptV25rgb_ch2, false);
% [albedo25_ch3, normals25_ch3] = estimate_alb_nrm(image_stack25rgb_ch3, scriptV25rgb_ch3, false);
% 
% 
% [p25_ch1, q25_ch1, SE25_ch1] = check_integrability(normals25_ch1);
% [p25_ch2, q25_ch2, SE25_ch2] = check_integrability(normals25_ch2);
% [p25_ch3, q25_ch3, SE25_ch3] = check_integrability(normals25_ch3);
% 
% threshold = 0.005;
% 
% SE25_ch1(SE25_ch1 <= threshold) = NaN; % for good visualization
% SE25_ch2(SE25_ch2 <= threshold) = NaN; % for good visualization
% SE25_ch3(SE25_ch3 <= threshold) = NaN; % for good visualization
% 
% height_map_ch1 = construct_surface( p25_ch1, q25_ch1, "average");
% height_map_ch2 = construct_surface( p25_ch2, q25_ch2, "average");
% height_map_ch3 = construct_surface( p25_ch3, q25_ch3, "average");
% 
% figure(1)
% subplot(2,2,1);
% imshow(height_map_ch1);
% title("albedo25_ch1")
% subplot(2,2,2);
% imshow(height_map_ch2);
% title("albedo25_ch2")
% subplot(2,2,3);
% imshow(height_map_ch3);
% title("albedo55_ch3")
% return;

%image_ext = '*.png';
% 5 Images
[image_stack5, scriptV5] = load_syn_images(image_dir_5, 5);
[h5, w5, n5] = size(image_stack5);
fprintf('Finish loading %d images.\n\n', n5);

% compute the surface gradient from the stack of imgs and light source mat
disp('Computing surface albedo and normal map...')
[albedo5, normals5] = estimate_alb_nrm(image_stack5, scriptV5, false);
[albedo5_trick, normals5_trick] = estimate_alb_nrm(image_stack5, scriptV5);

% 25 Images
[image_stack25, scriptV25] = load_syn_images(image_dir_25, 25);
[h25, w25, n25] = size(image_stack25);
fprintf('Finish loading %d images.\n\n', n25);

% compute the surface gradient from the stack of imgs and light source mat
disp('Computing surface albedo and normal map...')
[albedo25, normals25] = estimate_alb_nrm(image_stack25, scriptV25, false);
[albedo25_trick, normals25_trick] = estimate_alb_nrm(image_stack25, scriptV25);

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
%     
%     [image_stack_i, scriptV_i] = load_syn_images(image_dir_25, num_images);
%     [albedo_i, normals_i] = estimate_alb_nrm(image_stack_i, scriptV_i, false);
%     
%     i = i + 1;
%     subplot(2, 5, i)
%     imshow(albedo_i)
%     title(num_images)
%     subplot(2, 5, i + 5)
%     imshow(normals_i)
%     title(num_images)
% end

%% integrability check: is (dp / dy  -  dq / dx) ^ 2 small everywhere?
disp('Integrability checking')
[p5, q5, SE5] = check_integrability(normals5_trick);
[p25, q25, SE25] = check_integrability(normals25_trick);

threshold = 0.005;
SE5(SE5 <= threshold) = NaN; % for good visualization
SE25(SE25 <= threshold) = NaN; % for good visualization
% figure(3)
% subplot(1,2,1)
% imshow(SE5);
% title(sum(sum(SE5 > threshold)))
% subplot(1,2,2)
% imshow(SE25);
% title(sum(sum(SE25 > threshold)))

% display(size(SE))
fprintf('Number of outliers SE5: %d\n\n', sum(sum(SE5 > threshold)));
fprintf('Number of outliers SE25: %d\n\n', sum(sum(SE25 > threshold)));

%% compute the surface height
height_map_avg = construct_surface( p5, q5, "average");
height_map_row = construct_surface( p5, q5, "row");
height_map_column = construct_surface( p5, q5, "column");

figure(3)
subplot(2,2,1)
imshow(height_map_avg);
title("average")
subplot(2,2,2)
imshow(height_map_row);
title("row")
subplot(2,2,3);
imshow(height_map_column);
title("column")
%% Display
show_model(albedo5_trick, height_map_avg);
return;
%
%% Face
[image_stack, scriptV] = load_face_images('./photometrics_images/MonkeyGray/');
[h, w, n] = size(image_stack);
fprintf('Finish loading %d images.\n\n', n);
disp('Computing surface albedo and normal map...')
[albedo, normals] = estimate_alb_nrm(image_stack, scriptV);

%% integrability check: is (dp / dy  -  dq / dx) ^ 2 small everywhere?
disp('Integrability checking')
[p, q, SE] = check_integrability(normals);

threshold = 0.005;
SE(SE <= threshold) = NaN; % for good visualization
fprintf('Number of outliers: %d\n\n', sum(sum(SE > threshold)));

%% compute the surface height
height_map = construct_surface( p, q );

%show_results(albedo, normals, SE);
show_model(albedo, height_map);

