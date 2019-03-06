clear all

% get path
path1 = "./pingpong/"; % if run from assignment_3 folder
% path1 = "./../pingpong/"; % if run from part_3 folder
path2 = "./person_toy/"; % if run from assignment_3 folder
% path2 = "./../person_toy/"; % if run from part_3 folder

% get video
pingpong_imgs = read_directory(path1, '*', ".jpeg");
pingpong_imgs = pingpong_imgs;
% toy_imgs = read_directory(path2, '*', ".jpg");

% track objects through video
[points_pingpong, vectors_pingpong]  = tracking(pingpong_imgs);
% tracked_toy = tracking(toy_imgs);

% show video with points
show(pingpong_imgs, points_pingpong, vectors_pingpong)
% show(toy_imgs, tracked_toy)

