function [crossval_all]=RunTrainingScript_InfoGains_and_InfoGainMAD(round, arff_folder, top_k)

SetEnvironment
SetPath

path_to_scaled_arffs = strcat(g_str_pathbase_radar,'/IIITDemo/Arff/BigEnvs/Round',num2str(round),'/',num2str(arff_folder));
path_to_combined_arff_scaled = strcat(path_to_scaled_arffs,'/combined');
path_to_out_mats = strcat(path_to_scaled_arffs,'/outmats');

path_to_topk_arffs_scaled = strcat(path_to_scaled_arffs,strcat('/top',num2str(top_k))); % '\top20' or '\top10', depending on which top-k feature set you want
path_to_InfoGain_arffs = strcat(path_to_topk_arffs_scaled,'/InfoGain_combined'); % combined file

%Create InfoGain features folder if it doesn't  exist
if exist(path_to_InfoGain_arffs, 'dir') ~= 7
    mkdir(path_to_InfoGain_arffs); % Includes path_to_topk_arffs_scaled
    fprintf('INFO: created directory %s\n', path_to_InfoGain_arffs);
end

if exist(path_to_out_mats, 'dir') ~= 7
    mkdir(path_to_out_mats); % Includes path_to_topk_arffs_scaled
    fprintf('INFO: created directory %s\n', path_to_out_mats);
end

%% Attribute selection for top_k Information Gain ranked features
fprintf('Computing Information Gain feature selection\n');
fprintf('--------------------------------------------\n');
[InfoGain_features,~,~,~] = InformationGainOfAFeatureOfAFile_weka(path_to_combined_arff_scaled,top_k);
fprintf('--------------------------------------------\n\n');

InfoGain_features_file_suffix = sprintf('%.0f_',InfoGain_features);
InfoGain_features_file_suffix = strcat('f_', InfoGain_features_file_suffix(1:end-1));

InfoGain_features_csv = sprintf('%.0f,' , InfoGain_features);
InfoGain_features_csv = InfoGain_features_csv(1:end-1);

%% Create downsized output files -- top_k Information Gain features
% Training files
cd(path_to_combined_arff_scaled);
fileFullNames=dir;

i=1;
Files={};
for j=1:length(fileFullNames)
    s=fileFullNames(j).name;
    k=strfind(s,'.arff');
    if ~isempty(k) && k>=2 && k+4==length(s)
        Files{i}=s(1:k-1);
        i=i+1;
    end
end

for i=1:length(Files) % take every file from the set 'Files'
    infileFullName = strcat(path_to_combined_arff_scaled,'/',Files{i},'.arff');
    outfileName = strcat(path_to_InfoGain_arffs,'/',Files{i},'_', InfoGain_features_file_suffix,'.arff');
    AttributeSelectionManual_Arff(infileFullName, outfileName, InfoGain_features_csv);
end

clear Files fileFullNames

%% Generate models and compute corresponding best crossvalidation results
% Generate models for top_k Information Gain features
fprintf('Generating models for Information Gain ranked features\n');
fprintf('------------------------------------------------------\n');
crossval_InfoGain = GenerateModels_IoTDI(g_str_pathbase_model, path_to_InfoGain_arffs);
fprintf('------------------------------------------------------\n\n');

save(strcat(path_to_out_mats,'/crossval_InfoGain_',num2str(top_k),'.mat'),'crossval_InfoGain');

%% Run InfoGainMAD algorithms -- delegated to function RunTrainingScript_InfoGainMAD
[crossval_InfoGainMAD_25] = RunTrainingScript_InfoGainMAD(arff_folder, 0.25, round, top_k, 's');
[crossval_InfoGainMAD_50] = RunTrainingScript_InfoGainMAD(arff_folder, 0.5, round, top_k, 's');
[crossval_InfoGainMAD_75] = RunTrainingScript_InfoGainMAD(arff_folder, 0.75, round, top_k, 's');
[crossval_InfoGainMAD_full] = RunTrainingScript_InfoGainMAD(arff_folder, 1.0, round, top_k, 's');
[crossval_InfoGainMAD_5x] = RunTrainingScript_InfoGainMAD(arff_folder, 5.0, round, top_k, 's');
[crossval_InfoGainMAD_10x] = RunTrainingScript_InfoGainMAD(arff_folder, 10.0, round, top_k, 's');
[crossval_InfoGainMAD_20x] = RunTrainingScript_InfoGainMAD(arff_folder, 20.0, round, top_k, 's');
[crossval_InfoGainMAD_50x] = RunTrainingScript_InfoGainMAD(arff_folder, 50.0, round, top_k, 's');

alpha = {'25', '50', '75', 'full', '10x', '50x'};
for a=1:length(alpha)
    save(strcat(path_to_out_mats,'/crossval_InfoGainMAD_alpha_',alpha{a},'_',num2str(top_k),'.mat'),strcat('crossval_InfoGainMAD_',alpha{a}));
end

%% Compute crossval matrix
crossval_all = [[ crossval_InfoGain{:,4} ]' [ crossval_InfoGainMAD_25{:,4} ]' [ crossval_InfoGainMAD_50{:,4} ]' [ crossval_InfoGainMAD_75{:,4} ]' [ crossval_InfoGainMAD_full{:,4} ]' [ crossval_InfoGainMAD_5x{:,4} ]' [ crossval_InfoGainMAD_10x{:,4} ]' [ crossval_InfoGainMAD_20x{:,4} ]' [ crossval_InfoGainMAD_50x{:,4} ]'];
fprintf('Computed matrices!!\n\n');