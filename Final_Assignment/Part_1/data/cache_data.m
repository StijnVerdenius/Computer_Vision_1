function cache_data(name, obj)
% saves a dataobject from cache folder


save(get_path("cache")+name, "obj");

disp("Saved succesfully: " + name);

end