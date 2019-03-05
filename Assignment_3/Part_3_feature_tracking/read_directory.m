function files = read_directory(path, name, extension)



D = path;
S = dir(fullfile(D,name+extension)); % pattern to match filenames.
for k = 1:numel(S)
    F = fullfile(D,S(k).name);
    I = imread(F);
    S(k).data = I; % optional, save data.
end

files = S;

end