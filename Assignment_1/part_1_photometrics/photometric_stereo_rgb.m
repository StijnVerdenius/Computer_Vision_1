function [] = photometric_stereo_rgb(dir, num_imgs, shadow)

[image_stack25rgb_ch1, scriptV25rgb_ch1] = load_syn_images(dir, num_imgs, 1);
[image_stack25rgb_ch2, scriptV25rgb_ch2] = load_syn_images(dir, num_imgs, 2);
[image_stack25rgb_ch3, scriptV25rgb_ch3] = load_syn_images(dir, num_imgs, 3);
% 
% 
[albedo25_ch1, normals25_ch1] = estimate_alb_nrm(image_stack25rgb_ch1, scriptV25rgb_ch1, shadow);
[albedo25_ch2, normals25_ch2] = estimate_alb_nrm(image_stack25rgb_ch2, scriptV25rgb_ch2, shadow);
[albedo25_ch3, normals25_ch3] = estimate_alb_nrm(image_stack25rgb_ch3, scriptV25rgb_ch3, shadow);
% 
% 
albedo25_ch2(isnan(albedo25_ch2))=0;
normals25_ch2(isnan(normals25_ch2))=0;
[p25_ch1, q25_ch1, SE25_ch1] = check_integrability(normals25_ch1);
[p25_ch2, q25_ch2, SE25_ch2] = check_integrability(normals25_ch2);
[p25_ch3, q25_ch3, SE25_ch3] = check_integrability(normals25_ch3);
% 
threshold = 0.005;
% 
SE25_ch1(SE25_ch1 <= threshold) = NaN; % for good visualization
fprintf('Number of outliers: %d\n\n', sum(sum(SE25_ch1 > threshold)));

SE25_ch2(SE25_ch2 <= threshold) = NaN; % for good visualization
fprintf('Number of outliers: %d\n\n', sum(sum(SE25_ch2 > threshold)));

SE25_ch3(SE25_ch3 <= threshold) = NaN; % for good visualization
fprintf('Number of outliers: %d\n\n', sum(sum(SE25_ch3 > threshold)));

% 
height_map_ch1 = construct_surface( p25_ch1, q25_ch1, "average");
height_map_ch2 = construct_surface( p25_ch2, q25_ch2, "average");
height_map_ch3 = construct_surface( p25_ch3, q25_ch3, "average");


albedo = cat(3,albedo25_ch1,albedo25_ch2,albedo25_ch3);
normals = (normals25_ch1 + normals25_ch2 + normals25_ch3)/3
height_map = (height_map_ch1 + height_map_ch2 + height_map_ch3)/3;
SE = (SE25_ch1 + SE25_ch2 + SE25_ch3)/3;
show_results(albedo, normals, SE);
show_model(albedo, height_map);
end