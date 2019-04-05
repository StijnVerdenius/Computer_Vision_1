%% main function 


%% fine-tune cnn

% [net, info, expdir] = finetune_cnn();

%% extract features and train svm

expdir = "Part_2\data\cnn_assignment-lenet";
nets.fine_tuned = load(fullfile(expdir, '50bs-80e\net-epoch-80.mat')); nets.fine_tuned = nets.fine_tuned.net;
nets.pre_trained = load(fullfile('data', 'pre_trained_model.mat')); nets.pre_trained = nets.pre_trained.net; 
data = load(fullfile(expdir, 'imdb-stl.mat'));

%% Visualizations

% pre-trained
pre = nets.pre_trained;
pre.layers = pre.layers(1:12); % get rid of softmax layer
[trainset_pre, testset_pre] = get_svm_data_gl(data, pre);
tsne(trainset_pre.features, trainset_pre.labels);

% fine-tuned
fine = nets.fine_tuned;
fine.layers = fine.layers(1:12); %get rid of softmax layer
[trainset_fine, testset_fine] = get_svm_data_gl(data, fine);
tsne(trainset_fine.features, trainset_fine.labels);

%%
train_svm(nets, data);
