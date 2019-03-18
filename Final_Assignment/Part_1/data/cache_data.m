function cache_data(name, obj, cache_version)
% saves a dataobject from cache folder


save(get_path("cache")+name+"_"+cache_version, "obj");

disp("Saved succesfully: " + name);

end