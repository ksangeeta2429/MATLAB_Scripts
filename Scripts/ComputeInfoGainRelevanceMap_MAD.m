function ComputeInfoGainRelevanceMap_MAD(path_to_scaled_arffs)

SetEnvironment
SetPath

import weka.attributeSelection.userExtensions.CustomMIToolbox;

path_to_single_arffs_scaled = strcat(path_to_scaled_arffs,'/single_envs');

%% Compute relevance statistics and variance scores across hold-one-out environments
cd(path_to_single_arffs_scaled);
envFiles = dir('*.arff');
for k=1:length(envFiles)
    instances = loadARFF(envFiles(k).name);
    relevance_matrix(:,k) = CustomMIToolbox.InfoGain_RelevanceMap(instances);
end

%% Calculate scaled 0-1 variance scores
% variances = info_gain_stats(:,2);
% variance_scores = (variances-min(variances(:))) ./ (max(variances(:)-min(variances(:))));

for m=1:size(relevance_matrix,1)
    mad_scores(m) = mad(relevance_matrix(m,:),1);
end

%% Save output
outfile = strcat(path_to_scaled_arffs,'/InfoGainMAD.txt');
dlmwrite(outfile, mad_scores);