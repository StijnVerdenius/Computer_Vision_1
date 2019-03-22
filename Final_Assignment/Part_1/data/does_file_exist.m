function boolean = does_file_exist(name, cache_version)	 % DOCSTRING_GENERATED
 % DOES_FILE_EXIST		 [sees if file exists in cache]
 % INPUTS 
 %			name = file base-name without path
 %			cache_version = the version of the base-name
 % OUTPUTS 
 %			boolean = yes or no


% 

boolean = isfile(get_path("cache")+name+"_"+cache_version+".mat");

end