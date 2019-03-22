function cache_data(name, obj, cache_version)	 % DOCSTRING_GENERATED
 % CACHE_DATA		 [saves object to cache file]
 % INPUTS 
 %			name = base-name
 %			obj = object to be saved
 %			cache_version = version-name, to further specify


save(get_path("cache")+name+"_"+cache_version, "obj");

disp("Saved succesfully: " + name);

end