function obj = load_cached_data(name)
% loads a dataobject from cache folder

loaded = load(get_path("cache")+name, "obj");

obj = loaded.obj;

disp("Loaded succesfully: "+ name);

end