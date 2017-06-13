function RunTrainingScript_RandomSplits_InfoGainMAD(arff_folder, alpha, seed, round, top_k, heldout_or_single)

SetEnvironment
SetPath

import weka.attributeSelection.*;
import weka.filters.Filter;
import weka.filters.supervised.attribute.Discretize;
import weka.attributeSelection.userExtensions.CustomMIToolbox;

path_to_scaled_arffs = strcat(g_str_pathbase_radar,'/IIITDemo/Arff/Randseed',num2str(seed),'/Round',num2str(round),'/',num2str(arff_folder));
path_to_combined_arff_scaled = strcat(path_to_scaled_arffs,'/combined');

path_to_single_arffs_scaled = strcat(path_to_scaled_arffs,'/single_envs');
path_to_topk_arffs_scaled = strcat(path_to_scaled_arffs,strcat('/top',num2str(top_k))); % '\top20' or '\top10', depending on which top-k feature set you want

path_to_InfoGainMAD_arffs = strcat(path_to_topk_arffs_scaled,'/InfoGainMAD_',strrep(num2str(alpha),'.','_'),heldout_or_single); % combined file

%Create InfoGainMAD features folderd if they don't exist
if exist(path_to_InfoGainMAD_arffs, 'dir') ~= 7
    mkdir(path_to_InfoGainMAD_arffs); % Includes path_to_topk_arffs_scaled
    fprintf('INFO: created directory %s\n', path_to_InfoGainMAD_arffs);
end

%% Compute relevance statistics and variance scores across hold-one-out environments
fprintf('Computing Relevance statistics\n');
fprintf('------------------------------\n');
cd(path_to_single_arffs_scaled);
envFiles = dir('*.arff');
for k=1:length(envFiles)
    fprintf('Processing file %s\n', envFiles(k).name);
    instances = loadARFF(envFiles(k).name);
    relevance_matrix(:,k) = CustomMIToolbox.InfoGain_RelevanceMap(instances);
end
fprintf('------------------------------\n\n');

% % Calculate scaled 0-1 variance scores
% variances = info_gain_stats(:,2);
% variance_scores = (variances-min(variances(:))) ./ (max(variances(:)-min(variances(:))));

for m=1:size(relevance_matrix,1)
    mad_scores(m) = mad(relevance_matrix(m,:),1);
end

fprintf('Computing InfoGainMAD alpha=%f feature selection\n',alpha);
fprintf('----------------------------------\n');
[InfoGainMAD_features, ~] = ComputeInfoGainMAD(top_k, path_to_combined_arff_scaled, alpha, mad_scores);
fprintf('----------------------------------\n\n');

InfoGainMAD_features_file_suffix = sprintf('%.0f_',InfoGainMAD_features);
InfoGainMAD_features_file_suffix = strcat('f_', InfoGainMAD_features_file_suffix(1:end-1));

InfoGainMAD_features_csv = sprintf('%.0f,' , InfoGainMAD_features);
InfoGainMAD_features_csv = InfoGainMAD_features_csv(1:end-1);

%% Create downsized output files
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
    outfileName = strcat(path_to_InfoGainMAD_arffs,'/',Files{i},'_', InfoGainMAD_features_file_suffix,'.arff');
    AttributeSelectionManual_Arff(infileFullName, outfileName, InfoGainMAD_features_csv);
end

clear Files fileFullNames