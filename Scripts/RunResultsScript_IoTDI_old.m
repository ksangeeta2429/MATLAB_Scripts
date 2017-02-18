function [crossval_nr, crossval_r, crossenvironment_nr, crossenvironment_r]=RunResultsScript_IoTDI_old(arff_folder, top_k)
%% RunResultsScript_IoTDI.m

% EXAMPLE OF CALLING RunResultsScript_IoTDI:
% ---------------------------------------------------------
% RunResultsScript_IoTDI('jin_emote',20)
% RunResultsScript_IoTDI('dhrubo_matlab',10)
% ---------------------------------------------------------

% The script computes top_k best features based on .arff file in
% arff_folder\combined subfolder and checks their cross-environmental robustness based on arff_folder\unscaled, extracts corresponding features in arff_folder\scaled,
% creates models in g_str_pathbase_model, and generates cross-environmental performance results for both non-robust and robust feature sets.

%% Function body
SetEnvironment
SetPath

path_to_combined_arff = strcat(g_str_pathbase_radar,'/IIITDemo/Arff/',arff_folder,'/combined'); 
path_to_unscaled_arffs = strcat(g_str_pathbase_radar,'/IIITDemo/Arff/',arff_folder,'/unscaled'); 
path_to_heldout_arffs = strcat(path_to_unscaled_arffs,'/heldout_envs');
path_to_topk_arffs_unscaled = strcat(path_to_heldout_arffs,strcat('/top',num2str(top_k))); % '\top20' or '\top10', depending on which top-k feature set you want

path_to_scaled_arffs = strcat(g_str_pathbase_radar,'/IIITDemo/Arff/',arff_folder,'/scaled'); 
path_to_topk_arffs_scaled = strcat(path_to_scaled_arffs,strcat('/top',num2str(top_k))); % '\top20' or '\top10', depending on which top-k feature set you want
path_to_robust_arffs = strcat(path_to_topk_arffs_scaled,'/robust');
path_to_mRMR_D_arffs = strcat(path_to_topk_arffs_scaled,'/mRMR_D'); % combined file
path_to_mRMRV_D_arffs = strcat(path_to_topk_arffs_scaled,'/mRMRV_D'); % combined file
path_to_max_mRMR_D_arffs = strcat(path_to_topk_arffs_scaled,'/max_mRMR_D');
path_to_min_mRMR_D_arffs = strcat(path_to_topk_arffs_scaled,'/min_mRMR_D');
path_to_mean_mRMR_D_arffs = strcat(path_to_topk_arffs_scaled,'/mean_mRMR_D');
path_to_median_mRMR_D_arffs = strcat(path_to_topk_arffs_scaled,'/median_mRMR_D');


%Create top_k folder (unscaled) if it doesn't  exist
if exist(path_to_topk_arffs_unscaled, 'dir') ~= 7
    mkdir(path_to_topk_arffs_unscaled);
    fprintf('INFO: created directory %s\n', path_to_topk_arffs_unscaled);
end

%Create robust features folder if it doesn't  exist
if exist(path_to_robust_arffs, 'dir') ~= 7
    mkdir(path_to_robust_arffs); % Includes path_to_topk_arffs_scaled
    fprintf('INFO: created directory %s\n', path_to_robust_arffs);
end

%Create mRMR_D features folder if it doesn't  exist
if exist(path_to_mRMR_D_arffs, 'dir') ~= 7
    mkdir(path_to_mRMR_D_arffs); % Includes path_to_topk_arffs_scaled
    fprintf('INFO: created directory %s\n', path_to_mRMR_D_arffs);
end

%Create mRMRV_D features folder if it doesn't  exist
if exist(path_to_mRMRV_D_arffs, 'dir') ~= 7
    mkdir(path_to_mRMRV_D_arffs); % Includes path_to_topk_arffs_scaled
    fprintf('INFO: created directory %s\n', path_to_mRMRV_D_arffs);
end

%Create max_mRMRV_D features folder if it doesn't  exist
if exist(path_to_max_mRMR_D_arffs, 'dir') ~= 7
    mkdir(path_to_max_mRMR_D_arffs); % Includes path_to_topk_arffs_scaled
    fprintf('INFO: created directory %s\n', path_to_max_mRMR_D_arffs);
end

%Create min_mRMRV_D features folder if it doesn't  exist
if exist(path_to_min_mRMR_D_arffs, 'dir') ~= 7
    mkdir(path_to_min_mRMR_D_arffs); % Includes path_to_topk_arffs_scaled
    fprintf('INFO: created directory %s\n', path_to_min_mRMR_D_arffs);
end

%Create mean_mRMRV_D features folder if it doesn't  exist
if exist(path_to_mean_mRMR_D_arffs, 'dir') ~= 7
    mkdir(path_to_mean_mRMR_D_arffs); % Includes path_to_topk_arffs_scaled
    fprintf('INFO: created directory %s\n', path_to_mean_mRMR_D_arffs);
end

%Create median_mRMRV_D features folder if it doesn't  exist
if exist(path_to_median_mRMR_D_arffs, 'dir') ~= 7
    mkdir(path_to_median_mRMR_D_arffs); % Includes path_to_topk_arffs_scaled
    fprintf('INFO: created directory %s\n', path_to_median_mRMR_D_arffs);
end

%% Attribute selection for top_k (unscaled) features
% Compute information gains from Weka. To use Jin's computation, use: InformationGainOfAFeatureOfAFile(path_to_combined_arff, 20)
[maxk,~,~] = InformationGainOfAFeatureOfAFile_weka(path_to_combined_arff, -1); % Last parameter - 20 for top20 features, 10 for top10 features, -1 for all features

% features_file_suffix = sprintf('%.0f_' , maxk);
% features_file_suffix = strcat('f_', features_file_suffix(1:end-1));

features_file_suffix = 'f_all';

features_csv = sprintf('%.0f,' , maxk);
features_csv = features_csv(1:end-1);

cd(path_to_heldout_arffs);
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
    infileFullName = strcat(path_to_heldout_arffs,'/',Files{i},'.arff');
    outfileName = strcat(path_to_topk_arffs_unscaled,'/',Files{i},'_',features_file_suffix,'.arff');
    AttributeSelectionManual_Arff(infileFullName, outfileName, features_csv); % Downselect the top_k features in terms of information gain
end

% Compute information gains from Weka. To use Jin's computation, use: InformationGainOfAFeatureOfAFile(path_to_topk_arffs_unscaled,[])
[info_gain_stats,~,~] = InformationGainOfAFeatureOfAFile_weka(path_to_topk_arffs_unscaled,[]);

%% Commented by Dhrubo
% info_gain_stats = [double(maxk) info_gain_stats]; % Use [double(maxk') info_gain_stats] if using InformationGainOfAFeatureOfAFile(path_to_topk_arffs_unscaled,[])
% info_gain_stats_robust = info_gain_stats(info_gain_stats(:,3)<=0.05,:); % Change to 0.05
% info_gain_stats_robust = info_gain_stats(info_gain_stats(:,3)<=0.05,:); % Using variance rather than SD

%% Attribute selection for top_k (scaled) features
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
    outfileName = strcat(path_to_topk_arffs_scaled,'/',Files{i},'_',features_file_suffix,'.arff');
    AttributeSelectionManual_Arff(infileFullName, outfileName, features_csv);
end

%% Commented by Dhrubo - Attribute selection for robust (scaled) features out of the top_k
% features_robust = int8(info_gain_stats_robust(:,1))';
% 
% features_robust_file_suffix = sprintf('%.0f_' , features_robust);
% features_robust_file_suffix = strcat('f_', features_robust_file_suffix(1:end-1));
% 
% features_robust_csv = sprintf('%.0f,' , features_robust);
% features_robust_csv = features_robust_csv(1:end-1);
% 
% cd(path_to_scaled_arffs);
% fileFullNames=dir;
% 
% i=1;
% Files={};
% for j=1:length(fileFullNames)
%     s=fileFullNames(j).name;
%     k=strfind(s,'.arff');
%     if ~isempty(k) && k>=2 && k+4==length(s) 
%         Files{i}=s(1:k-1);
%         i=i+1;
%     end
% end
% 
% for i=1:length(Files) % take every file from the set 'Files'
%     infileFullName = strcat(path_to_scaled_arffs,'/',Files{i},'.arff');
%     outfileName = strcat(path_to_robust_arffs,'/',Files{i},'_',features_robust_file_suffix,'.arff');
%     AttributeSelectionManual_Arff(infileFullName, outfileName, features_robust_csv);
% end
%% Attribute selection for top_k mRMR_D features

Stop or my mom will shoot!

features_robust_file_suffix = sprintf('%.0f_' , features_robust);
features_robust_file_suffix = strcat('f_', features_robust_file_suffix(1:end-1));

features_robust_csv = sprintf('%.0f,' , features_robust);
features_robust_csv = features_robust_csv(1:end-1);

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
    outfileName = strcat(path_to_robust_arffs,'/',Files{i},'_',features_robust_file_suffix,'.arff');
    AttributeSelectionManual_Arff(infileFullName, outfileName, features_robust_csv);
end

%% Attribute selection for top_k mRMRV_D features
% Calculate scaled 0-1 variance scores
variances = info_gain_stats(:,2);
variance_scores = (variances-min(variances(:))) ./ (max(variances(:)-min(variances(:))));

%% Generate models for scaled top_k and robust features
crossval_nr = GenerateModels_IoTDI(g_str_pathbase_model, path_to_topk_arffs_scaled);
crossval_r = GenerateModels_IoTDI(g_str_pathbase_model, path_to_robust_arffs);

%% Generate cross-environment results from stored models
crossenvironment_nr = GenerateCrossEnvironmentResults_IoTDI(g_str_pathbase_model, path_to_topk_arffs_scaled);
crossenvironment_r = GenerateCrossEnvironmentResults_IoTDI(g_str_pathbase_model, path_to_robust_arffs);