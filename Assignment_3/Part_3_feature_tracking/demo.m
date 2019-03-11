clear all
close all

% get path
path1 = "./pingpong/"; % if run from assignment_3 folder
% path1 = "./../pingpong/"; % if run from part_3 folder
path2 = "./person_toy/"; % if run from assignment_3 folder
% path2 = "./../person_toy/"; % if run from part_3 folder

% get video
pingpong_imgs = read_directory(path1, '*', ".jpeg");
pingpong_imgs = pingpong_imgs(1:end); % comment for full video
toy_imgs = read_directory(path2, '*', ".jpg");
toy_imgs = toy_imgs(1:end); % comment for full video

% track objects through video
[points_pingpong, vectors_pingpong]  = tracking(pingpong_imgs, 8);
[points_toy, vectors_toy]  = tracking(toy_imgs, 2); % uncomment for other video

% show video with points
show(pingpong_imgs, points_pingpong, vectors_pingpong)
show(toy_imgs, points_toy, vectors_toy) % uncomment for other video