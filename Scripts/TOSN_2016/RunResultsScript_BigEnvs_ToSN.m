function [crossval_all, crossenv_all]=RunResultsScript_BigEnvs_ToSN(round, arff_folder, top_k)

SetEnvironment
SetPath

path_to_scaled_arffs = strcat(g_str_pathbase_radar,'/IIITDemo/Arff/BigEnvs/Round',num2str(round),'/',num2str(arff_folder));
path_to_combined_arff_scaled = strcat(path_to_scaled_arffs,'/combined');
path_to_test_arffs = strcat(path_to_scaled_arffs,'/test');
path_to_out_mats = strcat(path_to_scaled_arffs,'/outmats');

path_to_topk_arffs_scaled = strcat(path_to_scaled_arffs,strcat('/top',num2str(top_k))); % '\top20' or '\top10', depending on which top-k feature set you want
path_to_InfoGain_arffs = strcat(path_to_topk_arffs_scaled,'/InfoGain_combined'); % combined file
path_to_mRMR_D_arffs = strcat(path_to_topk_arffs_scaled,'/mRMR_D_combined'); % combined file

path_to_topk_test = strcat(path_to_test_arffs,strcat('/top',num2str(top_k)));
path_to_InfoGain_test = strcat(path_to_topk_test,'/InfoGain_combined');
path_to_mRMR_D_test = strcat(path_to_topk_test,'/mRMR_D_combined');

%Create InfoGain features folder if it doesn't  exist
if exist(path_to_InfoGain_arffs, 'dir') ~= 7
    mkdir(path_to_InfoGain_arffs); % Includes path_to_topk_arffs_scaled
    fprintf('INFO: created directory %s\n', path_to_InfoGain_arffs);
end

%Create mRMR_D features folder if they don't exist
if exist(path_to_mRMR_D_arffs, 'dir') ~= 7
    mkdir(path_to_mRMR_D_arffs); % Includes path_to_topk_arffs_scaled
    fprintf('INFO: created directory %s\n', path_to_mRMR_D_arffs);
end

if exist(path_to_out_mats, 'dir') ~= 7
    mkdir(path_to_out_mats); % Includes path_to_topk_arffs_scaled
    fprintf('INFO: created directory %s\n', path_to_out_mats);
end

if exist(path_to_InfoGain_test, 'dir') ~= 7
    mkdir(path_to_InfoGain_test); % Includes path_to_topk_arffs_scaled
    fprintf('INFO: created directory %s\n', path_to_InfoGain_test);
end

if exist(path_to_mRMR_D_test, 'dir') ~= 7
    mkdir(path_to_mRMR_D_test); % Includes path_to_topk_arffs_scaled
    fprintf('INFO: created directory %s\n', path_to_mRMR_D_test);
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

%% Attribute selection for top_k mRMR_D features
fprintf('Computing MRMR_D feature selection\n');
fprintf('----------------------------------\n');
[mRMR_D_features, ~] = ComputeMRMR_D(top_k, path_to_combined_arff_scaled);
fprintf('----------------------------------\n\n');

mRMR_D_features_file_suffix = sprintf('%.0f_',mRMR_D_features);
mRMR_D_features_file_suffix = strcat('f_', mRMR_D_features_file_suffix(1:end-1));

mRMR_D_features_csv = sprintf('%.0f,' , mRMR_D_features);
mRMR_D_features_csv = mRMR_D_features_csv(1:end-1);

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

% Test files
cd(path_to_test_arffs);
testFileFullNames=dir;

i=1;
testFiles={};
for j=1:length(testFileFullNames)
    s=testFileFullNames(j).name;
    k=strfind(s,'.arff');
    if ~isempty(k) && k>=2 && k+4==length(s)
        testFiles{i}=s(1:k-1);
        i=i+1;
    end
end

for i=1:length(testFiles) % take every file from the set 'Files'
    infileFullName = strcat(path_to_test_arffs,'/',testFiles{i},'.arff');
    outfileName = strcat(path_to_InfoGain_test,'/',testFiles{i},'_', InfoGain_features_file_suffix,'.arff');
    AttributeSelectionManual_Arff(infileFullName, outfileName, InfoGain_features_csv);
end

clear testFiles testFileFullNames

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

% Test files
cd(path_to_test_arffs);
testFileFullNames=dir;

i=1;
testFiles={};
for j=1:length(testFileFullNames)
    s=testFileFullNames(j).name;
    k=strfind(s,'.arff');
    if ~isempty(k) && k>=2 && k+4==length(s)
        testFiles{i}=s(1:k-1);
        i=i+1;
    end
end

for i=1:length(testFiles) % take every file from the set 'Files'
    infileFullName = strcat(path_to_test_arffs,'/',testFiles{i},'.arff');
    outfileName = strcat(path_to_mRMR_D_test,'/',testFiles{i},'_', mRMR_D_features_file_suffix,'.arff');
    AttributeSelectionManual_Arff(infileFullName, outfileName, mRMR_D_features_csv);
end

clear testFiles testFileFullNames

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

save(strcat(path_to_out_mats,'/crossval_InfoGain_',num2str(top_k),'.mat'),'crossval_InfoGain');
save(strcat(path_to_out_mats,'/crossval_mRMR_D_',num2str(top_k),'.mat'),'crossval_mRMR_D');

%% Generate cross-environment results from stored models
fprintf('Generating cross-environment validation from Information Gain ranked features\n');
fprintf('-----------------------------------------------------------------------------\n');
crossenvironment_InfoGain = GenerateCrossEnvironmentResults_HumanOnly_IoTDI(g_str_pathbase_model, path_to_InfoGain_arffs, path_to_InfoGain_test);
% crossenvironment_InfoGain = GenerateCrossEnvironmentResults_IoTDI(g_str_pathbase_model, path_to_InfoGain_arffs, path_to_InfoGain_test);
fprintf('-----------------------------------------------------------------------------\n\n');

fprintf('Generating cross-environment validation from mRMR_D ranked features\n');
fprintf('-------------------------------------------------------------------\n');
crossenvironment_mRMR_D = GenerateCrossEnvironmentResults_HumanOnly_IoTDI(g_str_pathbase_model, path_to_mRMR_D_arffs, path_to_mRMR_D_test);
% crossenvironment_mRMR_D = GenerateCrossEnvironmentResults_IoTDI(g_str_pathbase_model, path_to_mRMR_D_arffs, path_to_mRMR_D_test);
fprintf('-------------------------------------------------------------------\n\n');

save(strcat(path_to_out_mats,'/crossenvironment_InfoGain_',num2str(top_k),'.mat'),'crossenvironment_InfoGain');
save(strcat(path_to_out_mats,'/crossenvironment_mRMR_D_',num2str(top_k),'.mat'),'crossenvironment_mRMR_D');

%% Run mRMR_D_minEnvs -- delegated to function Results_Sensys_mRMR_D_BigEnvs_minEnvs
[crossval_mRMR_D_minEnvs,crossenvironment_mRMR_D_minEnvs]=Results_Sensys_mRMR_D_BigEnvs_minEnvs(arff_folder, round, top_k);

save(strcat(path_to_out_mats,'/crossval_mRMR_D_minEnvs_',num2str(top_k),'.mat'),'crossval_mRMR_D_minEnvs');
save(strcat(path_to_out_mats,'/crossenvironment_mRMR_D_minEnvs_',num2str(top_k),'.mat'),'crossenvironment_mRMR_D_minEnvs');

%% Run mRMR_D algorithms -- delegated to function Results_Sensys_mRMRMAD_D_BigEnvs
[crossval_mRMRMAD_D_norm_25, crossenvironment_mRMRMAD_D_norm_25] = Results_Sensys_mRMRMAD_D_BigEnvs(arff_folder, 0.25, round, top_k, 's');
[crossval_mRMRMAD_D_norm_50, crossenvironment_mRMRMAD_D_norm_50] = Results_Sensys_mRMRMAD_D_BigEnvs(arff_folder, 0.5, round, top_k, 's');
[crossval_mRMRMAD_D_norm_75, crossenvironment_mRMRMAD_D_norm_75] = Results_Sensys_mRMRMAD_D_BigEnvs(arff_folder, 0.75, round, top_k, 's');
[crossval_mRMRMAD_D_norm_full, crossenvironment_mRMRMAD_D_norm_full] = Results_Sensys_mRMRMAD_D_BigEnvs(arff_folder, 1.0, round, top_k, 's');
[crossval_mRMRMAD_D_norm_10x, crossenvironment_mRMRMAD_D_norm_10x] = Results_Sensys_mRMRMAD_D_BigEnvs(arff_folder, 10.0, round, top_k, 's');
[crossval_mRMRMAD_D_norm_50x, crossenvironment_mRMRMAD_D_norm_50x] = Results_Sensys_mRMRMAD_D_BigEnvs(arff_folder, 50.0, round, top_k, 's');

alpha = {'25', '50', '75', 'full', '10x', '50x'};
for a=1:length(alpha)
    save(strcat(path_to_out_mats,'/crossval_mRMRMAD_D_norm_alpha_',alpha{a},'_',num2str(top_k),'.mat'),strcat('crossval_mRMRMAD_D_norm_',alpha{a}));
    save(strcat(path_to_out_mats,'/crossenvironment_mRMRMAD_D_norm_alpha_',alpha{a},'_',num2str(top_k),'.mat'),strcat('crossenvironment_mRMRMAD_D_norm_',alpha{a}));
end

%% Compute crossval matrix
crossval_all = [[ crossval_InfoGain{:,4} ]' [ crossval_mRMR_D{:,4} ]' [ crossval_mRMR_D_minEnvs{:,4} ]' [ crossval_mRMRMAD_D_norm_25{:,4} ]' [ crossval_mRMRMAD_D_norm_50{:,4} ]' [ crossval_mRMRMAD_D_norm_75{:,4} ]' [ crossval_mRMRMAD_D_norm_full{:,4} ]' [ crossval_mRMRMAD_D_norm_10x{:,4} ]' [ crossval_mRMRMAD_D_norm_50x{:,4} ]'];
crossenv_all = [[ crossenvironment_InfoGain{:,3} ]' [ crossenvironment_mRMR_D{:,3} ]' [ crossenvironment_mRMR_D_minEnvs{:,3} ]' [ crossenvironment_mRMRMAD_D_norm_25{:,3} ]' [ crossenvironment_mRMRMAD_D_norm_50{:,3} ]' [ crossenvironment_mRMRMAD_D_norm_75{:,3} ]' [ crossenvironment_mRMRMAD_D_norm_full{:,3} ]' [ crossenvironment_mRMRMAD_D_norm_10x{:,3} ]' [ crossenvironment_mRMRMAD_D_norm_50x{:,3} ]'];
fprintf('Computed matrices!!\n\n');