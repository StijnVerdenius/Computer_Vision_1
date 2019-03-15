function boolean = does_file_exist(name)

boolean = isfile(get_path("cache")+name+".mat");

end