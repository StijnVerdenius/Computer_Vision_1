clear all

path1 = "./pingpong/"; % if run from assignment_3 folder
% path1 = "./../pingpong/"; % if run from part_3 folder
path2 = "./person_toy/"; % if run from assignment_3 folder
% path2 = "./../person_toy/"; % if run from part_3 folder

pingpong_imgs = read_directory(path1, '*', ".jpeg");
toy_imgs = read_directory(path2, '*', ".jpg");

tracked_pingpong = tracking(pingpong_imgs);
tracked_toy = tracking(toy_imgs);

% show(tracked_pingpong)
% show(tracked_toy)

