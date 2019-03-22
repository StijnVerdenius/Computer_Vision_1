function [net, info, expdir] = finetune_cnn(varargin)

%% Define options
run('vl_setupnn.m') ;

opts.modelType = 'lenet' ;
[opts, varargin] = vl_argparse(opts, varargin) ;

opts.expDir = fullfile('Part_2/data', ...
  sprintf('cnn_assignment-%s', opts.modelType)) ;
[opts, varargin] = vl_argparse(opts, varargin) ;

opts.dataDir = 'Part_2/data/' ;
opts.imdbPath = fullfile(opts.expDir, 'imdb-stl.mat');
opts.whitenData = true ;
opts.contrastNormalization = true ;
opts.networkType = 'simplenn' ;
opts.train = struct() ;
opts = vl_argparse(opts, varargin) ;
if ~isfield(opts.train, 'gpus'), opts.train.gpus = []; end

%% update model

net = update_model();

%% TODO: Implement getIMDB function below

if exist(opts.imdbPath, 'file')
  imdb = load(opts.imdbPath) ;
else
  imdb = getIMDB() ;
  mkdir(opts.expDir) ;
  save(opts.imdbPath, '-struct', 'imdb') ;
end

%%
net.meta.classes.name = imdb.meta.classes(:)' ;

% -------------------------------------------------------------------------
%                                                                     Train
% -------------------------------------------------------------------------

trainfn = @cnn_train ;
[net, info] = trainfn(net, imdb, getBatch(opts), ...
  'expDir', opts.expDir, ...
  net.meta.trainOpts, ...
  opts.train, ...
  'val', find(imdb.images.set == 2)) ;

expdir = opts.expDir;
end
% -------------------------------------------------------------------------
function fn = getBatch(opts)
% -------------------------------------------------------------------------
switch lower(opts.networkType)
  case 'simplenn'
    fn = @(x,y) getSimpleNNBatch(x,y) ;
  case 'dagnn'
    bopts = struct('numGpus', numel(opts.train.gpus)) ;
    fn = @(x,y) getDagNNBatch(bopts,x,y) ;
end

end

function [images, labels] = getSimpleNNBatch(imdb, batch)

% -------------------------------------------------------------------------
images = single(imdb.images.data(:,:,:,batch)) ;
labels = imdb.images.labels(batch) ;
if rand > 0.5, images=fliplr(images) ; end

end

% -------------------------------------------------------------------------
function imdb = getIMDB()
% -------------------------------------------------------------------------
% Preapre the imdb structure, returns image data with mean image subtracted
classes = {'airplanes', 'birds', 'ships', 'horses', 'cars'};
% splits = {'train', 'test'};

%% TODO: Implement your loop here, to create the data structure described in the assignment
%% Use train.mat and test.mat we provided from STL-10 to fill in necessary data members for training below
%% You will need to, in a loop function,  1) read the image, 2) resize the image to (32,32,3), 3) read the label of that image

% load data
train = load('Part_1\data\stl10_matlab\train.mat');
test = load('Part_1\data\stl10_matlab\test.mat');

% add indicator attribute
train.indicator = 1;
test.indicator = 2;

% indicators for the relevant classes (airplane bird car horse ship)
relevant_classes = [1 2 3 7 9];

% initialzie data, labels and sets
new_length = length(train.y)/2 + length(test.y)/2;
data = zeros(32, 32, 3, new_length);
labels = zeros(1, new_length);
sets = zeros(1, new_length); 

idx = 0;

train_test = {train, test};

for j=1:2
    
    set = train_test{1};
    
    % keep only relevant classes
    condition = ismember(set.y, relevant_classes);
    set.X = set.X(condition, :);
    set.y = set.y(condition);

    for i=1:size(set.X, 1)
        
        idx = idx + 1;
        
        % get image and reshape it to rgb
        im_array = set.X(i, :);
        im_rgb = reshape(im_array, 96, 96, 3);
        
        data(: ,:, :, idx) = imresize(im_rgb, 1/3); % rescaled to 32, 32, 3
        labels(idx) = set.y(i);
        sets(idx) = set.indicator;
    end
    
end


%%
% subtract mean
dataMean = mean(data(:, :, :, sets == 1), 4);
data = bsxfun(@minus, data, dataMean);

imdb.images.data = single(data) ;
imdb.images.labels = single(labels) ;
imdb.images.set = sets;
imdb.meta.sets = {'train', 'val'} ;
imdb.meta.classes = classes;

perm = randperm(numel(imdb.images.labels));
imdb.images.data = imdb.images.data(:,:,:, perm);
imdb.images.labels = imdb.images.labels(perm);
imdb.images.set = imdb.images.set(perm);

end
