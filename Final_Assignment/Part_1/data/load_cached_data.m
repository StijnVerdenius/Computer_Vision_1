function obj = load_cached_data(name, cache_version)	 % DOCSTRING_GENERATED
 % LOAD_CACHED_DATA		 [loads a dataobject from cache folder]
 % INPUTS 
 %			name = file base-name without path
 %			cache_version = the version of the base-name
 % OUTPUTS 
 %			obj = your loaded object


loaded = load(get_path("cache")+name+"_"+cache_version+".mat", "obj");

obj = loaded.obj;

disp("Loaded succesfully: "+ name);

end