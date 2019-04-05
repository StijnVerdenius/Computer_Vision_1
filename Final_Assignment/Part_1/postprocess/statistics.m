function [] = statistics(sift_methods, colour_spaces, vocabulary_sizes)
% STATISTICS		 [conducts statistics on the data collected from all settings]
 % INPUTS 
 %			sift_methods = ['dense', 'keypoint']
 %			colorspaces = ['rgb', 'opponent' , 'Grayscale']
 %			vocabulary_sizes = [400, 1000, 4000]
 % OUTPUTS 
 %			results of Anderson-Darling normality test
 %          Results of 3-way ANOVA
 %          Bar plot of MAP for all settings
 %          Tables for MAP and standard deviation for all settings
 
 
experiment = [];
AP = [];
s_methods = [];
c_spaces = [];
v_sizes = [];
acc = [];

for s = 1:numel(sift_methods)
    for c = 1:numel(colour_spaces)
        for v = 1:numel(vocabulary_sizes)
            index = sift_methods(s) + "_" + colour_spaces(c) + "_" + vocabulary_sizes(v);
            experiment = [experiment, index];
            T = load_cached_data("result_table", index);
            AP = [AP, (T{1:5,{'Average_Precision'}})];
            acc = [acc, (T{1:5,{'Accuracy'}})];
            num = numel(T{1:5,{'Average_Precision'}});
            s_methods = [s_methods, repelem(sift_methods(s),num)];
            c_spaces = [c_spaces, repelem(colour_spaces(c),num)];
            v_sizes = [v_sizes, repelem(vocabulary_sizes(v), num)];
                
        end
    end
end


% Anderson-Darling normality test -----------------------------------------
for i = 1:length(AP)
    h = adtest(AP(:,i));
    if h
        display('The APs from experiment ' + experiment(i) + ' follow a normal distribution')
    end
end


% 3-way ANOVA--------------------------------------------------------------
[~,~,stats] = anovan(reshape(AP,1,numel(AP)),{s_methods,c_spaces,v_sizes},'model','interaction',...
    'varnames',{'sampling','colour space','vocabulary size'});

results = multcompare(stats,'Dimension',[1 2 3]);

% experiment

%Bar Plot -----------------------------------------------------------------
figure

M = mean(AP,1);
S = std(AP,1);
MA = mean(acc,1);
SA = std(acc,1);

colormap = colorcube;

%Dense means and std
M1 = [[M(1:3)]' [M(4:6)]' [M(7:9)]'];
S1 = [S(1:3);S(4:6);S(7:9)];
subplot(1,2,1)


hBar=bar(M1,'grouped', 'FaceColor','flat');      % basic grouped bar plot, keep handle
% colormap(3);
hFg=gcf; hAx=gca;             % handles to current figure, axes
ylim([0 1])                % space out a little extra room
hAx.XTickLabel={'400';'1000';'4000'}; % label x axis
% hAx.YColor=get(hFg,'color'); box off  % hide y axis/labels, outline
% hLg = legend(num2str([400;1000;4000]), ...
%            'orientation','horizontal', ...
%            'location','north'); legend('boxoff') % add legend

x=repmat([1:size(M1,1)].',1,size(M1,2));  % bar x nominals
xOff=bsxfun(@plus,x,[hBar.XOffset]); % bar midpoints x
hold all                             % keep axis limits, etc.
hEB=errorbar(xOff,M1,S1,'.');   % add errorbars
% hEB.Color = 'black';

for i=1:length(hBar)
  hEB(i).Color = 'black';
  hBar(i).FaceColor = colormap(57 + 2*rem(i,4),:);
end
title('Dense Sampling')
ylabel('Mean Average Precision (MAP)')

%Keypoint means and std
M2 = [[M(10:12)]' [M(13:15)]' [M(16:18)]'];
S2 = [S(10:12);S(13:15);S(16:18)];

subplot(1,2,2)

hBar=bar(M2,'grouped', 'FaceColor','flat');      % basic grouped bar plot, keep handle
% colormap(3);
hFg=gcf; hAx=gca;             % handles to current figure, axes
ylim([0 1])                % space out a little extra room
hAx.XTickLabel={'400';'1000';'4000'}; % label x axis
% hAx.YColor=get(hFg,'color');  % hide y axis/labels, outline

x=repmat([1:size(M2,1)].',1,size(M2,2));  % bar x nominals
xOff=bsxfun(@plus,x,[hBar.XOffset]); % bar midpoints x
hold all                             % keep axis limits, etc.
hEB=errorbar(xOff,M2,S2,'.');   % add errorbars
% hEB.Color = 'black';

for i=1:length(hBar)
  hEB(i).Color = 'black';
  hBar(i).FaceColor = colormap(57 + 2*rem(i,4),:);
end

title('Keypoint Sampling')

hLg = legend(["RGB";"Grayscale";"Opponent"]);
% 
sgtitle('MAP for colour space vs. vocabulary size vs. sampling method')
% newPosition = [0.77 0.77 0.2 0.2];
% set(hLg,'Position', newPosition);

%Tables --------------------------------------------------------------------

disp('Dense Sampling Table')
%Table displaying results for Dense sampling
colour_space = {"RGB 400";"RGB 1000";"RGB 4000"; "Grayscale 400";"Grayscale 1000";"Grayscale 4000"; "Opponent 400"; "Opponent 1000"; "Opponent 4000"};
% vocab_size = [[400, 1000, 4000];[400, 1000, 4000];[400, 1000, 4000]];
MAP = [M(1); M(2); M(3);M(4);M(5);M(6);M(7);M(8);M(9)];
SD = [S(1); S(2); S(3); S(4); S(5); S(6); S(7); S(8); S(9)];
ACC = [MA(1); MA(2); MA(3); MA(4); MA(5); MA(6); MA(7); MA(8); MA(9)];
SDA = [SA(1); SA(2); SA(3); SA(4); SA(5); SA(6); SA(7); SA(8); SA(9)];
T = table(colour_space, MAP, SD, ACC, SDA)

disp('Keypoint Sampling Table')
%Table displaying results for Keypoint sampling
colour_space = {"RGB 400";"RGB 1000";"RGB 4000"; "Grayscale 400";"Grayscale 1000";"Grayscale 4000"; "Opponent 400"; "Opponent 1000"; "Opponent 4000"};
% vocab_size = [[400, 1000, 4000];[400, 1000, 4000];[400, 1000, 4000]];
MAP = [M(10); M(11); M(12);M(13);M(14);M(15);M(16);M(17);M(18)];
SD = [S(10); S(11); S(12); S(13); S(14); S(15); S(16); S(17); S(18)];
ACC = [MA(10); MA(11); MA(12); MA(13); MA(14); MA(15); MA(16); MA(17); MA(18)];
SDA = [SA(10); SA(11); SA(12); SA(13); SA(14); SA(15); SA(16); SA(17); SA(18)];
T2 = table(colour_space, MAP,SD, ACC, SDA)
end







