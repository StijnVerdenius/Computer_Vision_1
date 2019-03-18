function obj = load_cached_data(name, cache_version)
% loads a dataobject from cache folder

loaded = load(get_path("cache")+name+"_"+cache_version+".mat", "obj");

obj = loaded.obj;

disp("Loaded succesfully: "+ name);

end