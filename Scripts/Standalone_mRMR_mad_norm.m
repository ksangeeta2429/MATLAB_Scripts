function [crossval_all, crossenv_all] = Standalone_mRMR_mad_norm(arff_folder, top_k, heldout_or_single)
SetEnvironment
SetPath

[crossval_mRMRV_D_norm_25, crossenvironment_mRMRV_D_norm_25] = Results_Sensys_mRMRV_D_norm(arff_folder, 0.25, top_k, heldout_or_single);
[crossval_mRMRV_D_norm_50, crossenvironment_mRMRV_D_norm_50] = Results_Sensys_mRMRV_D_norm(arff_folder, 0.5, top_k, heldout_or_single);
[crossval_mRMRV_D_norm_75, crossenvironment_mRMRV_D_norm_75] = Results_Sensys_mRMRV_D_norm(arff_folder, 0.75, top_k, heldout_or_single);
[crossval_mRMRV_D_norm_full, crossenvironment_mRMRV_D_norm_full] = Results_Sensys_mRMRV_D_norm(arff_folder, 1.0, top_k, heldout_or_single);
[crossval_mRMRV_D_norm_10x, crossenvironment_mRMRV_D_norm_10x] = Results_Sensys_mRMRV_D_norm(arff_folder, 10.0, top_k, heldout_or_single);
[crossval_mRMRV_D_norm_50x, crossenvironment_mRMRV_D_norm_50x] = Results_Sensys_mRMRV_D_norm(arff_folder, 50.0, top_k, heldout_or_single);

crossval_all = [[ crossval_mRMRV_D_norm_25{:,4} ]' [ crossval_mRMRV_D_norm_50{:,4} ]' [ crossval_mRMRV_D_norm_75{:,4} ]' [ crossval_mRMRV_D_norm_full{:,4} ]' [ crossval_mRMRV_D_norm_10x{:,4} ]' [ crossval_mRMRV_D_norm_50x{:,4} ]'];
crossenv_all = [[ crossenvironment_mRMRV_D_norm_25{:,3} ]' [ crossenvironment_mRMRV_D_norm_50{:,3} ]' [ crossenvironment_mRMRV_D_norm_75{:,3} ]' [ crossenvironment_mRMRV_D_norm_full{:,3} ]' [ crossenvironment_mRMRV_D_norm_10x{:,3} ]' [ crossenvironment_mRMRV_D_norm_50x{:,3} ]'];