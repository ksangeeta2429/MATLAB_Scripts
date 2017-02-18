function crossenv_all=CrossEnvs_BigEnvs_ToSN(round, arff_folder, top_k)

SetEnvironment
SetPath

path_to_scaled_arffs = strcat(g_str_pathbase_radar,'/IIITDemo/Arff/BigEnvs/Round',num2str(round),'/',num2str(arff_folder));
path_to_test_arffs = strcat(path_to_scaled_arffs,'/test');

path_to_topk_arffs_scaled = strcat(path_to_scaled_arffs,strcat('/top',num2str(top_k))); % '\top20' or '\top10', depending on which top-k feature set you want
path_to_InfoGain_arffs = strcat(path_to_topk_arffs_scaled,'/InfoGain_combined'); % combined file
path_to_mRMR_D_arffs = strcat(path_to_topk_arffs_scaled,'/mRMR_D_combined'); % combined file

path_to_topk_test = strcat(path_to_test_arffs,strcat('/top',num2str(top_k)));
path_to_InfoGain_test = strcat(path_to_topk_test,'/InfoGain_combined');
path_to_mRMR_D_test = strcat(path_to_topk_test,'/mRMR_D_combined');

%% Generate cross-environment results for InfoGain and mRMR
fprintf('Generating cross-environment validation from Information Gain ranked features\n');
fprintf('-----------------------------------------------------------------------------\n');
crossenvironment_InfoGain = GenerateCrossEnvironmentResults_HumanOnly_IoTDI(g_str_pathbase_model, path_to_InfoGain_arffs, path_to_InfoGain_test);
% crossenvironment_InfoGain = GenerateCrossEnvironmentResults_IoTDI(g_str_pathbase_model, path_to_InfoGain_arffs, path_to_InfoGain_test);
fprintf('----------------------------------------------------------------------------\n\n');

fprintf('Generating cross-environment validation from mRMR_D ranked features\n');
fprintf('-------------------------------------------------------------------\n');
crossenvironment_mRMR_D = GenerateCrossEnvironmentResults_HumanOnly_IoTDI(g_str_pathbase_model, path_to_mRMR_D_arffs, path_to_mRMR_D_test);
% crossenvironment_mRMR_D = GenerateCrossEnvironmentResults_IoTDI(g_str_pathbase_model, path_to_mRMR_D_arffs, path_to_mRMR_D_test);
fprintf('-------------------------------------------------------------------\n\n');

%% Generate cross-environment results for mRMR_D_minEnvs
crossenvironment_mRMR_D_minEnvs=CrossEnvs_mRMR_D_BigEnvs_minEnvs(arff_folder, round, top_k);

%% Generate cross-environment results for mRMR_MAD
crossenvironment_mRMRMAD_D_norm_25 = CrossEnvs_mRMRMAD_D(arff_folder, 0.25, round, top_k, 's');
crossenvironment_mRMRMAD_D_norm_50 = CrossEnvs_mRMRMAD_D(arff_folder, 0.5, round, top_k, 's');
crossenvironment_mRMRMAD_D_norm_75 = CrossEnvs_mRMRMAD_D(arff_folder, 0.75, round, top_k, 's');
crossenvironment_mRMRMAD_D_norm_full = CrossEnvs_mRMRMAD_D(arff_folder, 1.0, round, top_k, 's');
crossenvironment_mRMRMAD_D_norm_10x = CrossEnvs_mRMRMAD_D(arff_folder, 10.0, round, top_k, 's');
crossenvironment_mRMRMAD_D_norm_50x = CrossEnvs_mRMRMAD_D(arff_folder, 50.0, round, top_k, 's');

crossenv_all = [[ crossenvironment_InfoGain{:,3} ]' [ crossenvironment_mRMR_D{:,3} ]' [ crossenvironment_mRMR_D_minEnvs{:,3} ]' [ crossenvironment_mRMRMAD_D_norm_25{:,3} ]' [ crossenvironment_mRMRMAD_D_norm_50{:,3} ]' [ crossenvironment_mRMRMAD_D_norm_75{:,3} ]' [ crossenvironment_mRMRMAD_D_norm_full{:,3} ]' [ crossenvironment_mRMRMAD_D_norm_10x{:,3} ]' [ crossenvironment_mRMRMAD_D_norm_50x{:,3} ]'];
