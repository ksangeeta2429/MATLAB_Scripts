OutIndex = 103; % Enter OutIndex (Round#)
% Type in link to UNSCALED arff file
%% OutIndex 104
arff_file = 'C:\Users\neel\Downloads\radioarffweka\Humanvsnonhuman\bora_new_detector\M_30_N_128_window_res\Austere_fftmote\12_features\1005_f_390_humans_308_cows_final_12_features_forced.arff';
model_file = 'C:\Users\neel\Downloads\radioarffweka\Humanvsnonhuman\mote fft SV and weights\1005_final_12_features_mRMR_computed_on_mote_fft_model.txt'; % Type in link to human readable model file
%% OutIndex 103
% arff_file = 'C:\Users\royd\Box Sync\All_programs_data_IPSN_2016\Simulation\toDhruboMichael\IIITDemo\Arff\combined\radarALL_e_1_4_5_6_7_8_9_11_f_17_34_22_21_24_59_64_66_19_18_26_44.arff';
% model_file = 'C:\Users\royd\Desktop\Temp\testmodel_103.txt'; % Type in link to human readable model file

%% OutIndex 102
% arff_file = 'C:\Users\royd\Box Sync\All_programs_data_IPSN_2016\Simulation\toDhruboMichael\IIITDemo\Arff\BigEnvs\Round102\1_4_5_6_7_8_9_11\combined\ManuallySelectedAttributes\radarALL_scaled_e_1_4_5_6_7_8_9_11_f_17_34_22_21_24_59_64_66_19_18_26_44.arff';
% model_file = 'C:\Users\royd\Desktop\Temp\testmodel_102.txt'; % Type in link to human readable model file

%% Function body
[feature_min, scalingFactors] = GetFeatureMinScalingFactorsArff(arff_file);

[SV_matlab, param, gamma, rho, nRow]=Model2Matrix(model_file,length(feature_min));
Generate2DArrInCsharp(OutIndex,SV_matlab,param,gamma,rho,feature_min,scalingFactors);