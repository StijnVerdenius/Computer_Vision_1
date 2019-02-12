close all
clear all
clc
 
disp('Part 1: Photometric Stereo')

% obtain many images in a fixed view under different illumination
disp('Loading images...')
image_dir_5 = './photometrics_images/SphereGray25/';   % TODO: get the path of the script
image_dir_25 = './photometrics_images/SphereGray25/';   % TODO: get the path of the script

%image_ext = '*.png';
% 5 Images
[image_stack5, scriptV5] = load_syn_images(image_dir_5);
[h5, w5, n5] = size(image_stack5);
fprintf('Finish loading %d images.\n\n', n5);

% compute the surface gradient from the stack of imgs and light source mat
disp('Computing surface albedo and normal map...')
[albedo5, normals5] = estimate_alb_nrm(image_stack5, scriptV5);

% 25 Images
% [image_stack25, scriptV25] = load_syn_images(image_dir_25);
% [h25, w25, n25] = size(image_stack25);
% fprintf('Finish loading %d images.\n\n', n25);
% 
% % compute the surface gradient from the stack of imgs and light source mat
% disp('Computing surface albedo and normal map...')
% [albedo25, normals25] = estimate_alb_nrm(image_stack25, scriptV25);

% subplot(1,2,1);
% imshow(albedo5);
% subplot(1,2,2);
% imshow(albedo25);
%% integrability check: is (dp / dy  -  dq / dx) ^ 2 small everywhere?
disp('Integrability checking')
[p, q, SE] = check_integrability(normals5);

threshold = 0.005;
SE(SE <= threshold) = NaN; % for good visualization
fprintf('Number of outliers: %d\n\n', sum(sum(SE > threshold)));

%% compute the surface height
height_map = construct_surface( p, q );
% imshow(height_map)
%% Display
%show_model(albedo, height_map);
%

%% Face
[image_stack, scriptV] = load_face_images('./yaleB02/');
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

