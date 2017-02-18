SetEnvironment
SetPath

path_to_combined_arff = strcat(g_str_pathbase_radar,'\IIITDemo\Arff\jin_emote\combined');
path_to_unscaled_arffs = strcat(g_str_pathbase_radar,'\IIITDemo\Arff\jin_emote\unscaled');
path_to_heldout_arffs = strcat(path_to_unscaled_arffs,'\heldout_envs');
path_to_topk_arffs_unscaled = strcat(path_to_heldout_arffs,'\top20');

path_to_scaled_arffs = strcat(g_str_pathbase_radar,'\IIITDemo\Arff\jin_emote\scaled');
path_to_topk_arffs_scaled = strcat(path_to_scaled_arffs,'\top20');
path_to_robust_arffs = strcat(path_to_topk_arffs_scaled,'\robust');

if exist(path_to_topk_arffs_unscaled, 'dir') ~= 7
    mkdir(path_to_topk_arffs_unscaled);
    fprintf('INFO: created directory %s\n', path_to_topk_arffs_unscaled);
end

if exist(path_to_robust_arffs, 'dir') ~= 7
    mkdir(path_to_robust_arffs); % Includes path_to_top10_arffs_scaled
    fprintf('INFO: created directory %s\n', path_to_robust_arffs);
end

%% Attribute selection for top-10 (unscaled) features
[maxk,~] = InformationGainOfAFeatureOfAFile(path_to_combined_arff, 20);

features_file_suffix = sprintf('%.0f_' , maxk);
features_file_suffix = strcat('f_', features_file_suffix(1:end-1));

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
    infileFullName = strcat(path_to_heldout_arffs,'\',Files{i},'.arff');
    outfileName = strcat(path_to_topk_arffs_unscaled,'\',Files{i},'_',features_file_suffix,'.arff');
    AttributeSelectionManual_Arff(infileFullName, outfileName, features_csv);
end

[info_gain_stats, ~] = InformationGainOfAFeatureOfAFile(path_to_topk_arffs_unscaled,[]);
info_gain_stats = [maxk' info_gain_stats];
info_gain_stats_robust = info_gain_stats(info_gain_stats(:,3)<=0.05,:); % Change to 0.05

%% Attribute selection for top-10 (scaled) features
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
    infileFullName = strcat(path_to_scaled_arffs,'\',Files{i},'.arff');
    outfileName = strcat(path_to_topk_arffs_scaled,'\',Files{i},'_',features_file_suffix,'.arff');
    AttributeSelectionManual_Arff(infileFullName, outfileName, features_csv);
end

%% Attribute selection for robust (scaled) features out of the top-10
features_robust = int8(info_gain_stats_robust(:,1))';

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
    infileFullName = strcat(path_to_scaled_arffs,'\',Files{i},'.arff');
    outfileName = strcat(path_to_robust_arffs,'\',Files{i},'_',features_robust_file_suffix,'.arff');
    AttributeSelectionManual_Arff(infileFullName, outfileName, features_robust_csv);
end

%% Generate models for scaled top-10 and robust features
crossval_nr = GenerateModels_IoTDI(g_str_pathbase_model, path_to_topk_arffs_scaled);
crossval_r = GenerateModels_IoTDI(g_str_pathbase_model, path_to_robust_arffs);

%% Generate cross-environment results from stored models for 
crossenvironment_nr = GenerateCrossEnvironmentResults_IoTDI(g_str_pathbase_model, path_to_topk_arffs_scaled);
crossenvironment_r = GenerateCrossEnvironmentResults_IoTDI(g_str_pathbase_model, path_to_robust_arffs);