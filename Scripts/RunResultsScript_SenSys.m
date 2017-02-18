% function [crossval_InfoGain, crossval_mRMR_D, crossenvironment_InfoGain, crossenvironment_mRMR_D,...
%     crossval_mRMRV_D_norm_25, crossenvironment_mRMRV_D_norm_25, crossval_mRMRV_D_norm_50, crossenvironment_mRMRV_D_norm_50,...
%     crossval_mRMRV_D_norm_75, crossenvironment_mRMRV_D_norm_75, crossval_mRMRV_D_norm_full, crossenvironment_mRMRV_D_norm_full,...
%     crossval_mRMRV_D_norm_10x, crossenvironment_mRMRV_D_norm_10x, crossval_mRMRV_D_norm_50x, crossenvironment_mRMRV_D_norm_50x,...
%     crossval_mRMRV_D_norm_100x, crossenvironment_mRMRV_D_norm_100x]=RunResultsScript_SenSys(arff_folder, top_k)

function [crossval_all,crossenv_all]=RunResultsScript_SenSys(arff_folder, top_k)
%% RunResultsScript_IoTDI.m

% EXAMPLE OF CALLING RunResultsScript_IoTDI:
% ---------------------------------------------------------
% RunResultsScript_IoTDI('jin_emote',20)
% RunResultsScript_IoTDI('dhrubo_matlab',10)
% ---------------------------------------------------------

% The script computes top_k best features based on .arff file in arff_folder/combined subfolder and checks their cross-environmental robustness based on arff_folder/unscaled,
% extracts corresponding features in arff_folder\scaled using mRMR_D and mRMRV_D, then creates models in g_str_pathbase_model,
% and generates cross-environmental performance results for both non-robust and robust feature sets.

%% Set path and environment, specify relevant data/result folders and create subfolders when required
SetEnvironment
SetPath

path_to_combined_arff = strcat(g_str_pathbase_radar,'/IIITDemo/Arff/',arff_folder,'/combined');
% path_to_unscaled_arffs = strcat(g_str_pathbase_radar,'/IIITDemo/Arff/',arff_folder,'/unscaled');
% path_to_heldout_arffs = strcat(path_to_unscaled_arffs,'/heldout_envs');
% path_to_topk_arffs_unscaled = strcat(path_to_heldout_arffs,strcat('/top',num2str(top_k))); % '\top20' or '\top10', depending on which top-k feature set you want

path_to_combined_arff_scaled = strcat(path_to_combined_arff,'/scaled');
path_to_scaled_arffs = strcat(g_str_pathbase_radar,'/IIITDemo/Arff/',arff_folder,'/scaled');
path_to_heldout_arffs_scaled = strcat(path_to_scaled_arffs,'/heldout_envs');
path_to_topk_arffs_scaled = strcat(path_to_scaled_arffs,strcat('/top',num2str(top_k))); % '\top20' or '\top10', depending on which top-k feature set you want
path_to_InfoGain_arffs = strcat(path_to_topk_arffs_scaled,'/InfoGain_combined'); % combined file
path_to_mRMR_D_arffs = strcat(path_to_topk_arffs_scaled,'/mRMR_D_combined'); % combined file
% path_to_mRMRV_D_1_0_arffs = strcat(path_to_topk_arffs_scaled,'/mRMRV_D_1.0_combined'); % combined file
% path_to_mRMRV_D_0_75_arffs = strcat(path_to_topk_arffs_scaled,'/mRMRV_D_0.75_combined'); % combined file
% path_to_mRMRV_D_0_5_arffs = strcat(path_to_topk_arffs_scaled,'/mRMRV_D_0.5_combined'); % combined file
% path_to_mRMRV_D_0_25_arffs = strcat(path_to_topk_arffs_scaled,'/mRMRV_D_0.25_combined'); % combined file
% path_to_max_mRMR_D_arffs = strcat(path_to_topk_arffs_scaled,'/max_mRMR_D');
% path_to_min_mRMR_D_arffs = strcat(path_to_topk_arffs_scaled,'/min_mRMR_D');
% path_to_mean_mRMR_D_arffs = strcat(path_to_topk_arffs_scaled,'/mean_mRMR_D');
% path_to_median_mRMR_D_arffs = strcat(path_to_topk_arffs_scaled,'/median_mRMR_D');

% %Create top_k folder (unscaled) if it doesn't  exist
% if exist(path_to_topk_arffs_unscaled, 'dir') ~= 7
%     mkdir(path_to_topk_arffs_unscaled);
%     fprintf('INFO: created directory %s\n', path_to_topk_arffs_unscaled);
% end

%Create InfoGain features folder if it doesn't  exist
if exist(path_to_InfoGain_arffs, 'dir') ~= 7
    mkdir(path_to_InfoGain_arffs); % Includes path_to_topk_arffs_scaled
    fprintf('INFO: created directory %s\n', path_to_InfoGain_arffs);
end

%Create mRMR_D features folderd if they don't exist
if exist(path_to_mRMR_D_arffs, 'dir') ~= 7
    mkdir(path_to_mRMR_D_arffs); % Includes path_to_topk_arffs_scaled
    fprintf('INFO: created directory %s\n', path_to_mRMR_D_arffs);
end

% %Create mRMRV_D features folderd if they don't exist
% if exist(path_to_mRMRV_D_1_0_arffs, 'dir') ~= 7
%     mkdir(path_to_mRMRV_D_1_0_arffs); % Includes path_to_topk_arffs_scaled
%     fprintf('INFO: created directory %s\n', path_to_mRMRV_D_1_0_arffs);
% end
%
% if exist(path_to_mRMRV_D_0_75_arffs, 'dir') ~= 7
%     mkdir(path_to_mRMRV_D_0_75_arffs); % Includes path_to_topk_arffs_scaled
%     fprintf('INFO: created directory %s\n', path_to_mRMRV_D_0_75_arffs);
% end
%
% if exist(path_to_mRMRV_D_0_25_arffs, 'dir') ~= 7
%     mkdir(path_to_mRMRV_D_0_25_arffs); % Includes path_to_topk_arffs_scaled
%     fprintf('INFO: created directory %s\n', path_to_mRMRV_D_0_25_arffs);
% end
%
% if exist(path_to_mRMRV_D_0_5_arffs, 'dir') ~= 7
%     mkdir(path_to_mRMRV_D_0_5_arffs); % Includes path_to_topk_arffs_scaled
%     fprintf('INFO: created directory %s\n', path_to_mRMRV_D_0_5_arffs);
% end

%Create max_mRMR_D features folder if it doesn't  exist
if exist(path_to_max_mRMR_D_arffs, 'dir') ~= 7
    mkdir(path_to_max_mRMR_D_arffs); % Includes path_to_topk_arffs_scaled
    fprintf('INFO: created directory %s\n', path_to_max_mRMR_D_arffs);
end

%Create min_mRMR_D features folder if it doesn't  exist
if exist(path_to_min_mRMR_D_arffs, 'dir') ~= 7
    mkdir(path_to_min_mRMR_D_arffs); % Includes path_to_topk_arffs_scaled
    fprintf('INFO: created directory %s\n', path_to_min_mRMR_D_arffs);
end

%Create mean_mRMR_D features folder if it doesn't  exist
if exist(path_to_mean_mRMR_D_arffs, 'dir') ~= 7
    mkdir(path_to_mean_mRMR_D_arffs); % Includes path_to_topk_arffs_scaled
    fprintf('INFO: created directory %s\n', path_to_mean_mRMR_D_arffs);
end

%Create median_mRMR_D features folder if it doesn't  exist
if exist(path_to_median_mRMR_D_arffs, 'dir') ~= 7
    mkdir(path_to_median_mRMR_D_arffs); % Includes path_to_topk_arffs_scaled
    fprintf('INFO: created directory %s\n', path_to_median_mRMR_D_arffs);
end

%% Compute information gain statistics and variance scores across hold-one-out environments
fprintf('Computing Information Gain statistics\n');
fprintf('---------------------------------------------\n');
% Compute information gains for each environments from Weka. To use Jin's computation, use: InformationGainOfAFeatureOfAFile(path_to_topk_arffs_scaled,[])
[info_gain_stats,~,~,~] = InformationGainOfAFeatureOfAFile_weka(path_to_heldout_arffs_scaled,[]);
fprintf('---------------------------------------------\n\n');

% Calculate scaled 0-1 variance scores
variances = info_gain_stats(:,2);
variance_scores = (variances-min(variances(:))) ./ (max(variances(:)-min(variances(:))));

%% Attribute selection for top_k Information Gain ranked features
fprintf('Computing Information Gain feature selection\n');
fprintf('--------------------------------------------\n');
[InfoGain_features,~,~,~] = InformationGainOfAFeatureOfAFile_weka(path_to_combined_arff_scaled,top_k);
fprintf('--------------------------------------------\n\n');

InfoGain_features_file_suffix = sprintf('%.0f_',InfoGain_features);
InfoGain_features_file_suffix = strcat('f_', InfoGain_features_file_suffix(1:end-1));

InfoGain_features_csv = sprintf('%.0f,' , InfoGain_features);
InfoGain_features_csv = InfoGain_features_csv(1:end-1);

%% Attribute selection for top_k mRMR_D features
fprintf('Computing MRMR_D feature selection\n');
fprintf('----------------------------------\n');
[mRMR_D_features, ~] = ComputeMRMR_D(top_k, path_to_combined_arff_scaled);
fprintf('----------------------------------\n\n');

mRMR_D_features_file_suffix = sprintf('%.0f_',mRMR_D_features);
mRMR_D_features_file_suffix = strcat('f_', mRMR_D_features_file_suffix(1:end-1));

mRMR_D_features_csv = sprintf('%.0f,' , mRMR_D_features);
mRMR_D_features_csv = mRMR_D_features_csv(1:end-1);

% %% Attribute selection for top_k mRMRV_D features
% fprintf('Computing MRMRV_D alpha=1.0 feature selection\n');
% fprintf('----------------------------------\n');
% [mRMRV_D_1_0_features, ~] = ComputeMRMRV_D(top_k, path_to_combined_arff_scaled, 1.0, variance_scores);
% fprintf('----------------------------------\n\n');
%
% mRMRV_D_1_0_features_file_suffix = sprintf('%.0f_',mRMRV_D_1_0_features);
% mRMRV_D_1_0_features_file_suffix = strcat('f_', mRMRV_D_1_0_features_file_suffix(1:end-1));
%
% mRMRV_D_1_0_features_csv = sprintf('%.0f,' , mRMRV_D_1_0_features);
% mRMRV_D_1_0_features_csv = mRMRV_D_1_0_features_csv(1:end-1);
%
% fprintf('Computing MRMRV_D alpha=0.75 feature selection\n');
% fprintf('----------------------------------\n');
% [mRMRV_D_0_75_features, ~] = ComputeMRMRV_D(top_k, path_to_combined_arff_scaled, 0.75, variance_scores);
% fprintf('----------------------------------\n\n');
%
% mRMRV_D_0_75_features_file_suffix = sprintf('%.0f_',mRMRV_D_0_75_features);
% mRMRV_D_0_75_features_file_suffix = strcat('f_', mRMRV_D_0_75_features_file_suffix(1:end-1));
%
% mRMRV_D_0_75_features_csv = sprintf('%.0f,' , mRMRV_D_0_75_features);
% mRMRV_D_0_75_features_csv = mRMRV_D_0_75_features_csv(1:end-1);
%
% fprintf('Computing MRMRV_D alpha=0.25 feature selection\n');
% fprintf('----------------------------------\n');
% [mRMRV_D_0_25_features, ~] = ComputeMRMRV_D(top_k, path_to_combined_arff_scaled, 0.25, variance_scores);
% fprintf('----------------------------------\n\n');
%
% mRMRV_D_0_25_features_file_suffix = sprintf('%.0f_',mRMRV_D_0_25_features);
% mRMRV_D_0_25_features_file_suffix = strcat('f_', mRMRV_D_0_25_features_file_suffix(1:end-1));
%
% mRMRV_D_0_25_features_csv = sprintf('%.0f,' , mRMRV_D_0_25_features);
% mRMRV_D_0_25_features_csv = mRMRV_D_0_25_features_csv(1:end-1);
%
% fprintf('Computing MRMRV_D alpha=0.5 feature selection\n');
% fprintf('----------------------------------\n');
% [mRMRV_D_0_5_features, ~] = ComputeMRMRV_D(top_k, path_to_combined_arff_scaled, 0.5, variance_scores);
% fprintf('----------------------------------\n\n');
%
% mRMRV_D_0_5_features_file_suffix = sprintf('%.0f_',mRMRV_D_0_5_features);
% mRMRV_D_0_5_features_file_suffix = strcat('f_', mRMRV_D_0_5_features_file_suffix(1:end-1));
%
% mRMRV_D_0_5_features_csv = sprintf('%.0f,' , mRMRV_D_0_5_features);
% mRMRV_D_0_5_features_csv = mRMRV_D_0_5_features_csv(1:end-1);

%% Create downsized output files
% Create downsized output files -- top_k Information Gain features
cd(path_to_scaled_arffs);
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
    infileFullName = strcat(path_to_scaled_arffs,'/',Files{i},'.arff');
    outfileName = strcat(path_to_InfoGain_arffs,'/',Files{i},'_', InfoGain_features_file_suffix,'.arff');
    AttributeSelectionManual_Arff(infileFullName, outfileName, InfoGain_features_csv);
end

% Create downsized output files -- top_k mRMR_D features
for i=1:length(Files) % take every file from the set 'Files'
    infileFullName = strcat(path_to_scaled_arffs,'/',Files{i},'.arff');
    outfileName = strcat(path_to_mRMR_D_arffs,'/',Files{i},'_', mRMR_D_features_file_suffix,'.arff');
    AttributeSelectionManual_Arff(infileFullName, outfileName, mRMR_D_features_csv);
end

% % Create downsized output files -- top_k mRMRV_D features
% for i=1:length(Files) % take every file from the set 'Files'
%     infileFullName = strcat(path_to_scaled_arffs,'/',Files{i},'.arff');
%     outfileName = strcat(path_to_mRMRV_D_1_0_arffs,'/',Files{i},'_', mRMRV_D_1_0_features_file_suffix,'.arff');
%     AttributeSelectionManual_Arff(infileFullName, outfileName, mRMRV_D_1_0_features_csv);
% end
%
% for i=1:length(Files) % take every file from the set 'Files'
%     infileFullName = strcat(path_to_scaled_arffs,'/',Files{i},'.arff');
%     outfileName = strcat(path_to_mRMRV_D_0_75_arffs,'/',Files{i},'_', mRMRV_D_0_75_features_file_suffix,'.arff');
%     AttributeSelectionManual_Arff(infileFullName, outfileName, mRMRV_D_0_75_features_csv);
% end
%
% for i=1:length(Files) % take every file from the set 'Files'
%     infileFullName = strcat(path_to_scaled_arffs,'/',Files{i},'.arff');
%     outfileName = strcat(path_to_mRMRV_D_0_25_arffs,'/',Files{i},'_', mRMRV_D_0_25_features_file_suffix,'.arff');
%     AttributeSelectionManual_Arff(infileFullName, outfileName, mRMRV_D_0_25_features_csv);
% end
%
%
% for i=1:length(Files) % take every file from the set 'Files'
%     infileFullName = strcat(path_to_scaled_arffs,'/',Files{i},'.arff');
%     outfileName = strcat(path_to_mRMRV_D_0_5_arffs,'/',Files{i},'_', mRMRV_D_0_5_features_file_suffix,'.arff');
%     AttributeSelectionManual_Arff(infileFullName, outfileName, mRMRV_D_0_5_features_csv);
% end

clear Files

%% Generate models and compute corresponding best crossvalidation results
% Generate models for top_k Information Gain features
fprintf('Generating models for Information Gain ranked features\n');
fprintf('------------------------------------------------------\n');
crossval_InfoGain = GenerateModels_IoTDI(g_str_pathbase_model, path_to_InfoGain_arffs);
fprintf('------------------------------------------------------\n\n');

% Generate models for top_k mRMR_D features
fprintf('Generating models for mRMR_D ranked features\n');
fprintf('--------------------------------------------\n');
crossval_mRMR_D = GenerateModels_IoTDI(g_str_pathbase_model, path_to_mRMR_D_arffs);
fprintf('--------------------------------------------\n\n');

% % Generate models for top_k mRMRV_D features
% fprintf('Generating models for mRMRV_D alpha = 1.0 ranked features\n');
% fprintf('--------------------------------------------\n');
% crossval_mRMRV_D_1_0 = GenerateModels_IoTDI(g_str_pathbase_model, path_to_mRMRV_D_1_0_arffs);
% fprintf('--------------------------------------------\n\n');
%
% fprintf('Generating models for mRMRV_D alpha = 0.75 ranked features\n');
% fprintf('--------------------------------------------\n');
% crossval_mRMRV_D_0_75 = GenerateModels_IoTDI(g_str_pathbase_model, path_to_mRMRV_D_0_75_arffs);
% fprintf('--------------------------------------------\n\n');
%
% fprintf('Generating models for mRMRV_D alpha = 0.25 ranked features\n');
% fprintf('--------------------------------------------\n');
% crossval_mRMRV_D_0_25 = GenerateModels_IoTDI(g_str_pathbase_model, path_to_mRMRV_D_0_25_arffs);
% fprintf('--------------------------------------------\n\n');
%
% fprintf('Generating models for mRMRV_D alpha = 0.5 ranked features\n');
% fprintf('--------------------------------------------\n');
% crossval_mRMRV_D_0_5 = GenerateModels_IoTDI(g_str_pathbase_model, path_to_mRMRV_D_0_5_arffs);
% fprintf('--------------------------------------------\n\n');

%% Generate cross-environment results from stored models
fprintf('Generating cross-environment validation from Information Gain ranked features\n');
fprintf('-----------------------------------------------------------------------------\n');
crossenvironment_InfoGain = GenerateCrossEnvironmentResults_IoTDI(g_str_pathbase_model, path_to_InfoGain_arffs);
fprintf('-----------------------------------------------------------------------------\n\n');

fprintf('Generating cross-environment validation from mRMR_D ranked features\n');
fprintf('-------------------------------------------------------------------\n');
crossenvironment_mRMR_D = GenerateCrossEnvironmentResults_IoTDI(g_str_pathbase_model, path_to_mRMR_D_arffs);
fprintf('-------------------------------------------------------------------\n\n');

% fprintf('Generating cross-environment validation from mRMRV_D alpha = 1.0 ranked features\n');
% fprintf('-------------------------------------------------------------------\n');
% crossenvironment_mRMRV_D_1_0 = GenerateCrossEnvironmentResults_IoTDI(g_str_pathbase_model, path_to_mRMRV_D_1_0_arffs);
% fprintf('-------------------------------------------------------------------\n\n');
%
% fprintf('Generating cross-environment validation from mRMRV_D alpha = 1.0 ranked features\n');
% fprintf('-------------------------------------------------------------------\n');
% crossenvironment_mRMRV_D_0_75 = GenerateCrossEnvironmentResults_IoTDI(g_str_pathbase_model, path_to_mRMRV_D_0_75_arffs);
% fprintf('-------------------------------------------------------------------\n\n');
%
% fprintf('Generating cross-environment validation from mRMRV_D alpha =
% 0.75 ranked features\n'); 
% fprintf('-------------------------------------------------------------------\n');
% crossenvironment_mRMRV_D_0_25 = GenerateCrossEnvironmentResults_IoTDI(g_str_pathbase_model, path_to_mRMRV_D_0_25_arffs);
% fprintf('-------------------------------------------------------------------\n\n');
%
% fprintf('Generating cross-environment validation from mRMRV_D alpha = 1.0 ranked features\n');
% fprintf('-------------------------------------------------------------------\n');
% crossenvironment_mRMRV_D_0_5 = GenerateCrossEnvironmentResults_IoTDI(g_str_pathbase_model, path_to_mRMRV_D_0_5_arffs);
% fprintf('-------------------------------------------------------------------\n\n');

%% Run mRMR_D algorithms -- delegated to function Results_Sensys_mRMRV_D_norm
[crossval_mRMRV_D_norm_25, crossenvironment_mRMRV_D_norm_25] = Results_Sensys_mRMRV_D_norm(arff_folder, 0.25, top_k);
[crossval_mRMRV_D_norm_50, crossenvironment_mRMRV_D_norm_50] = Results_Sensys_mRMRV_D_norm(arff_folder, 0.5, top_k);
[crossval_mRMRV_D_norm_75, crossenvironment_mRMRV_D_norm_75] = Results_Sensys_mRMRV_D_norm(arff_folder, 0.75, top_k);
[crossval_mRMRV_D_norm_full, crossenvironment_mRMRV_D_norm_full] = Results_Sensys_mRMRV_D_norm(arff_folder, 1.0, top_k);
[crossval_mRMRV_D_norm_10x, crossenvironment_mRMRV_D_norm_10x] = Results_Sensys_mRMRV_D_norm(arff_folder, 10.0, top_k);
[crossval_mRMRV_D_norm_50x, crossenvironment_mRMRV_D_norm_50x] = Results_Sensys_mRMRV_D_norm(arff_folder, 50.0, top_k);
% [crossval_mRMRV_D_norm_100x, crossenvironment_mRMRV_D_norm_100x] = Results_Sensys_mRMRV_D_norm(arff_folder, 100.0, top_k);

%% Compute crossval matrix
crossval_all = [[ crossval_InfoGain{:,4} ]' [ crossval_mRMR_D{:,4} ]' [ crossval_mRMRV_D_norm_25{:,4} ]' [ crossval_mRMRV_D_norm_50{:,4} ]' [ crossval_mRMRV_D_norm_75{:,4} ]' [ crossval_mRMRV_D_norm_full{:,4} ]' [ crossval_mRMRV_D_norm_10x{:,4} ]' [ crossval_mRMRV_D_norm_50x{:,4} ]'];
crossenv_all = [[ crossenvironment_InfoGain{:,3} ]' [ crossenvironment_mRMR_D{:,3} ]' [ crossenvironment_mRMRV_D_norm_25{:,3} ]' [ crossenvironment_mRMRV_D_norm_50{:,3} ]' [ crossenvironment_mRMRV_D_norm_75{:,3} ]' [ crossenvironment_mRMRV_D_norm_full{:,3} ]' [ crossenvironment_mRMRV_D_norm_10x{:,3} ]' [ crossenvironment_mRMRV_D_norm_50x{:,3} ]'];