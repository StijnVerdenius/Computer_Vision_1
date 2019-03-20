function path = get_path(keyword)
% gets a data path out given a keyword, such that when changing paths you
% only need to change one function and not go through all files.

main_path = "./Part_1";
delimiter = "/";
data_path = "data";
cached_path = "cached";
repository_path = "stl10_matlab";
results_path = "results";

if (strcmp(keyword, "raw_data"))
    path = main_path + delimiter + data_path + delimiter + repository_path + delimiter;
elseif (strcmp(keyword, "cache"))
    path = main_path + delimiter + data_path + delimiter + cached_path + delimiter;
elseif (strcmp(keyword, "results"))
    path = main_path + delimiter + data_path + delimiter + results_path + delimiter;
else
    error("cannot find path in function get_path.m: " + keyword);


end