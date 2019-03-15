function boolean = does_file_exist(name)
% sees if file exists in cache

boolean = isfile(get_path("cache")+name+".mat");

end