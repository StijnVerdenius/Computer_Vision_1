function boolean = does_file_exist(name, cache_version)
% sees if file exists in cache

boolean = isfile(get_path("cache")+name+"_"+cache_version+".mat");

end