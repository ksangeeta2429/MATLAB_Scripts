function [crossval_mRMR_D_minEnvs, crossenvironment_mRMR_D_minEnvs] = Results_Sensys_mRMR_D_minEnvs(arff_folder, top_k)

SetEnvironment
SetPath

% path_to_combined_arff = strcat(g_str_pathbase_radar,'/IIITDemo/Arff/',arff_folder,'/combined');
% path_to_combined_arff_scaled = strcat(path_to_combined_arff,'/scaled');
path_to_scaled_arffs = strcat(g_str_pathbase_radar,'/IIITDemo/Arff/',arff_folder,'/scaled');
path_to_heldout_arffs_scaled = strcat(path_to_scaled_arffs,'/heldout_envs');
path_to_single_arffs_scaled = strcat(path_to_scaled_arffs,'/single_envs');
path_to_topk_arffs_scaled = strcat(path_to_scaled_arffs,strcat('/top',num2str(top_k))); % '\top20' or '\top10', depending on which top-k feature set you want
path_to_mRMRV_D_arffs = strcat(path_to_topk_arffs_scaled,'/mRMR_D_minEnvs_singles'); % combined file

%Create mRMRV_D features folderd if they don't exist
if exist(path_to_mRMRV_D_arffs, 'dir') ~= 7
    mkdir(path_to_mRMRV_D_arffs); % Includes path_to_topk_arffs_scaled
    fprintf('INFO: created directory %s\n', path_to_mRMRV_D_arffs);
end

fprintf('Computing mRMR_D_minEnvs feature selection\n');
fprintf('------------------------------------------\n');
% [mRMRV_D_features, ~] = ComputeMRMRV_D_norm(top_k, path_to_combined_arff_scaled, alpha, variance_scores);
mRMRV_D_features = ComputemRMR_D_minEnvs(top_k, path_to_single_arffs_scaled);
fprintf('------------------------------------------\n\n');

mRMRV_D_features_file_suffix = sprintf('%.0f_',mRMRV_D_features);
mRMRV_D_features_file_suffix = strcat('f_', mRMRV_D_features_file_suffix(1:end-1));

mRMRV_D_features_csv = sprintf('%.0f,' , mRMRV_D_features);
mRMRV_D_features_csv = mRMRV_D_features_csv(1:end-1);

%% Create downsized output files
% Create downsized output files -- mRMRV_D Information Gain features
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
    outfileName = strcat(path_to_mRMRV_D_arffs,'/',Files{i},'_', mRMRV_D_features_file_suffix,'.arff');
    AttributeSelectionManual_Arff(infileFullName, outfileName, mRMRV_D_features_csv);
end

clear Files

%% Generate models and compute corresponding best crossvalidation results
% Generate models for top_k mRMRV_D features
fprintf('Generating models for mRMRV_D ranked features\n');
fprintf('---------------------------------------------\n');
crossval_mRMR_D_minEnvs = GenerateModels_IoTDI(g_str_pathbase_model, path_to_mRMRV_D_arffs);
fprintf('---------------------------------------------\n\n');

%% Generate cross-environment results from stored models
fprintf('Generating cross-environment validation from mRMRV_D ranked features\n');
fprintf('--------------------------------------------------------------------\n');
crossenvironment_mRMR_D_minEnvs = GenerateCrossEnvironmentResults_IoTDI(g_str_pathbase_model, path_to_mRMRV_D_arffs);
fprintf('--------------------------------------------------------------------\n\n');