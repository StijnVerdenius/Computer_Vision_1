function obj = load_cached_data(name)

loaded = load(get_path("cache")+name, "obj");

obj = loaded.obj;

disp("Loaded succesfully: "+ name);

end