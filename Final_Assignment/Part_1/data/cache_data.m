function cache_data(name, obj)

save(get_path("cache")+name, "obj");

disp("Saved succesfully: " + name);

end