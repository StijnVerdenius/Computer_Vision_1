function path = get_path(keyword)

main_path = "./Part_1";
delimiter = "/";
data_path = "data";
cached_path = "cached";
repository_path = "stl10_matlab";

if (strcmp(keyword, "raw_data"))
    path = main_path + delimiter + data_path + delimiter + repository_path + delimiter;
elseif (strcmp(keyword, "cache"))
    path = main_path + delimiter + data_path + delimiter + cached_path + delimiter;
else
    error("cannot find path in function get_path.m: " + keyword);


end