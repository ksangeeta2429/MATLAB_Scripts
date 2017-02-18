function crossenvironment_mRMR_D_minEnvs = CrossEnvs_mRMR_D_BigEnvs_minEnvs(arff_folder, round, top_k)
SetEnvironment
SetPath

path_to_scaled_arffs = strcat(g_str_pathbase_radar,'/IIITDemo/Arff/BigEnvs/Round',num2str(round),'/',num2str(arff_folder));
path_to_test_arffs = strcat(path_to_scaled_arffs,'/test');

path_to_topk_arffs_scaled = strcat(path_to_scaled_arffs,strcat('/top',num2str(top_k))); % '\top20' or '\top10', depending on which top-k feature set you want
path_to_mRMRV_D_arffs = strcat(path_to_topk_arffs_scaled,'/mRMR_D_minEnvs_s'); % combined file

path_to_topk_test = strcat(path_to_test_arffs,strcat('/top',num2str(top_k)));
path_to_mRMRV_D_test = strcat(path_to_topk_test,'/mRMR_D_minEnvs_s');

%% Generate cross-environment results from stored models
fprintf('Generating cross-environment validation from mRMR_D ranked features\n');
fprintf('--------------------------------------------------------------------\n');
crossenvironment_mRMR_D_minEnvs = GenerateCrossEnvironmentResults_IoTDI(g_str_pathbase_model, path_to_mRMRV_D_arffs, path_to_mRMRV_D_test);
fprintf('--------------------------------------------------------------------\n\n');