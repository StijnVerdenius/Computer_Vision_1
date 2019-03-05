function files = read_directory(path)



D = path;
S = dir(fullfile(D,'*.jpeg')); % pattern to match filenames.
for k = 1:numel(S)
    F = fullfile(D,S(k).name);
    I = imread(F);
%     imshow(I)
    S(k).data = I; % optional, save data.
end

files = S;

end