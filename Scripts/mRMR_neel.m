function mRMR_neel(top_k,path_to_combined_arff_scaled,outfile)
fprintf('Computing MRMR_D feature selection\n');
fprintf('----------------------------------\n');
[mRMR_D_features, ~] = ComputeMRMR_D(top_k, path_to_combined_arff_scaled);
fprintf('----------------------------------\n\n');

mRMR_D_features_file_suffix = sprintf('%.0f_',mRMR_D_features);
mRMR_D_features_file_suffix = strcat('f_', mRMR_D_features_file_suffix(1:end-1));

mRMR_D_features_csv = sprintf('%.0f,' , mRMR_D_features);
mRMR_D_features_csv = mRMR_D_features_csv(1:end-1);
disp(mRMR_D_features_csv);
infile = '/home/neel/radioarffweka/Bike data/Aug 9 2017/1humanvs5bike/combined/radar_x_z.arff';
AttributeSelectionManual_Arff(infile, outfile, mRMR_D_features_csv);
end