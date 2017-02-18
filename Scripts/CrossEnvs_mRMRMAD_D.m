function crossenvironment_mRMRMAD_D_norm = CrossEnvs_mRMRMAD_D(arff_folder, alpha, round, top_k, heldout_or_single)
SetEnvironment
SetPath

path_to_scaled_arffs = strcat(g_str_pathbase_radar,'/IIITDemo/Arff/BigEnvs/Round',num2str(round),'/',num2str(arff_folder));
path_to_test_arffs = strcat(path_to_scaled_arffs,'/test');

path_to_topk_arffs_scaled = strcat(path_to_scaled_arffs,strcat('/top',num2str(top_k))); % '\top20' or '\top10', depending on which top-k feature set you want

path_to_topk_test = strcat(path_to_test_arffs,strcat('/top',num2str(top_k)));
path_to_mRMRMAD_D_test = strcat(path_to_topk_test,'/mRMRMAD_D_',strrep(num2str(alpha),'.','_'),heldout_or_single);

path_to_mRMRMAD_D_arffs = strcat(path_to_topk_arffs_scaled,'/mRMRMAD_D_',strrep(num2str(alpha),'.','_'),heldout_or_single);

%% Generate cross-environment results from stored models
fprintf('Generating cross-environment validation from mRMRMAD_D alpha = %f ranked features\n',alpha);
fprintf('-------------------------------------------------------------------\n');
crossenvironment_mRMRMAD_D_norm = GenerateCrossEnvironmentResults_IoTDI(g_str_pathbase_model, path_to_mRMRMAD_D_arffs, path_to_mRMRMAD_D_test);
fprintf('-------------------------------------------------------------------\n\n');

