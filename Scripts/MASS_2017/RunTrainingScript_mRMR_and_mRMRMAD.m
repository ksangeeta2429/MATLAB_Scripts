function [crossval_all]=RunTrainingScript_mRMR_and_mRMRMAD(round, arff_folder, top_k)

SetEnvironment
SetPath

path_to_scaled_arffs = strcat(g_str_pathbase_radar,'/IIITDemo/Arff/BigEnvs/Round',num2str(round),'/',num2str(arff_folder));
path_to_combined_arff_scaled = strcat(path_to_scaled_arffs,'/combined');
path_to_out_mats = strcat(path_to_scaled_arffs,'/outmats');

path_to_topk_arffs_scaled = strcat(path_to_scaled_arffs,strcat('/top',num2str(top_k))); % '\top20' or '\top10', depending on which top-k feature set you want
path_to_mRMR_D_arffs = strcat(path_to_topk_arffs_scaled,'/mRMR_D_combined'); % combined file

%Create mRMR_D features folder if they don't exist
if exist(path_to_mRMR_D_arffs, 'dir') ~= 7
    mkdir(path_to_mRMR_D_arffs); % Includes path_to_topk_arffs_scaled
    fprintf('INFO: created directory %s\n', path_to_mRMR_D_arffs);
end

if exist(path_to_out_mats, 'dir') ~= 7
    mkdir(path_to_out_mats); % Includes path_to_topk_arffs_scaled
    fprintf('INFO: created directory %s\n', path_to_out_mats);
end

%% Attribute selection for top_k mRMR_D features
fprintf('Computing MRMR_D feature selection\n');
fprintf('----------------------------------\n');
[mRMR_D_features, ~] = ComputeMRMR_D(top_k, path_to_combined_arff_scaled);
fprintf('----------------------------------\n\n');

mRMR_D_features_file_suffix = sprintf('%.0f_',mRMR_D_features);
mRMR_D_features_file_suffix = strcat('f_', mRMR_D_features_file_suffix(1:end-1));

mRMR_D_features_csv = sprintf('%.0f,' , mRMR_D_features);
mRMR_D_features_csv = mRMR_D_features_csv(1:end-1);

%% Create downsized output files -- top_k mRMR_D features
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
    outfileName = strcat(path_to_mRMR_D_arffs,'/',Files{i},'_', mRMR_D_features_file_suffix,'.arff');
    AttributeSelectionManual_Arff(infileFullName, outfileName, mRMR_D_features_csv);
end

clear Files fileFullNames
%% Generate models and compute corresponding best crossvalidation results
% Generate models for top_k mRMR_D features
fprintf('Generating models for mRMR_D ranked features\n');
fprintf('--------------------------------------------\n');
crossval_mRMR_D = GenerateModels_IoTDI(g_str_pathbase_model, path_to_mRMR_D_arffs);
fprintf('--------------------------------------------\n\n');

save(strcat(path_to_out_mats,'/crossval_mRMR_D_',num2str(top_k),'.mat'),'crossval_mRMR_D');

%% Run mRMRMAD_D algorithms -- delegated to function RunTrainingScript_mRMRMAD
[crossval_mRMRMAD_D_25] = RunTrainingScript_mRMRMAD(arff_folder, 0.25, round, top_k, 's');
[crossval_mRMRMAD_D_50] = RunTrainingScript_mRMRMAD(arff_folder, 0.5, round, top_k, 's');
[crossval_mRMRMAD_D_75] = RunTrainingScript_mRMRMAD(arff_folder, 0.75, round, top_k, 's');
[crossval_mRMRMAD_D_full] = RunTrainingScript_mRMRMAD(arff_folder, 1.0, round, top_k, 's');
[crossval_mRMRMAD_D_5x] = RunTrainingScript_mRMRMAD(arff_folder, 5.0, round, top_k, 's');
[crossval_mRMRMAD_D_10x] = RunTrainingScript_mRMRMAD(arff_folder, 10.0, round, top_k, 's');
[crossval_mRMRMAD_D_20x] = RunTrainingScript_mRMRMAD(arff_folder, 20.0, round, top_k, 's');
[crossval_mRMRMAD_D_50x] = RunTrainingScript_mRMRMAD(arff_folder, 50.0, round, top_k, 's');

alpha = {'25', '50', '75', 'full', '10x', '50x'};
for a=1:length(alpha)
    save(strcat(path_to_out_mats,'/crossval_mRMRMAD_D_alpha_',alpha{a},'_',num2str(top_k),'.mat'),strcat('crossval_mRMRMAD_D_',alpha{a}));
end

%% Compute crossval matrix
crossval_all = [[ crossval_mRMR_D{:,4} ]' [ crossval_mRMRMAD_D_25{:,4} ]' [ crossval_mRMRMAD_D_50{:,4} ]' [ crossval_mRMRMAD_D_75{:,4} ]' [ crossval_mRMRMAD_D_full{:,4} ]' [ crossval_mRMRMAD_D_5x{:,4} ]' [ crossval_mRMRMAD_D_10x{:,4} ]' [ crossval_mRMRMAD_D_20x{:,4} ]' [ crossval_mRMRMAD_D_50x{:,4} ]'];
fprintf('Computed matrices!!\n\n');