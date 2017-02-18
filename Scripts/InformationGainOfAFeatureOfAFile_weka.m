function [output, info_gains_matrix, ranked_attributes, file_processing_order] = InformationGainOfAFeatureOfAFile_weka(path_arff, top_k)
%% InformationGainOfAFeatureOfAFile_weka.m

% EXAMPLE OF CALLING InformationGainOfAFeatureOfAFile_weka:
% ---------------------------------------------------------
% InformationGainOfAFeatureOfAFile_weka('C:\Users\royd\Box Sync\All_programs_data_IPSN_2016\Simulation\toDhruboMichael\IIITDemo\Arff\jin_emote\combined',20)
% InformationGainOfAFeatureOfAFile_weka('C:\Users\royd\Box Sync\All_programs_data_IPSN_2016\Simulation\toDhruboMichael\IIITDemo\Arff\jin_emote\combined',-1)
% ---------------------------------------------------------

% The script ranks the features from a Weka .arff in file in path_arff descending order of information gain.

% Outputs:
% 1. 'info_gains_matrix' returns the full information gain matrix.
% 2. 'output' returns the top_k ranked attributes (all attributes in descending order if top_k=-1) if there is just one .arff file in path_arff.
%    If there are multiple files, 'output' returns the information gain mean, variance and standard deviation for each file.
% 3. 'r_stats' is a binary that indicates if the matrix in 'output' is information gain statistics.

%% Function body

import weka.attributeSelection.*;
cd(path_arff);
envFiles = dir('*.arff');

for k=1:length(envFiles)
    fprintf('Processing file %s\n', envFiles(k).name);
    file_processing_order{k} = envFiles(k).name;
    
    instances = loadARFF(envFiles(k).name);
    
    evaluator = InfoGainAttributeEval();
    
    ranker = Ranker(); 
    selector = AttributeSelection();
    
    selector.setEvaluator(evaluator);
    selector.setSearch(ranker);
    selector.SelectAttributes(instances);
    
    
    ranked_attributes(:,k) = selector.selectedAttributes()+1; % +1 for adjusting indices from Weka to MATLAB
    selection_matrix = selector.rankedAttributes();
    info_gains_matrix(:,k) = selection_matrix(:,2);
end

if size(info_gains_matrix, 2) ==1
    %% If single environment, return top-k features
    if top_k == -1
        output = ranked_attributes(1:length(ranked_attributes)-1);
    else
        output = ranked_attributes(1:top_k); % If a single environment, return the top k information gain feature indices
    end
else
    %% If many environments, get information gain statistics
    ranked_attributes = ranked_attributes(1:size(ranked_attributes,1)-1,:);
    
    % Find information gain values for each feature (reordering needed since sort order different across environments), and compute info gain statistics
    final_info_gains = zeros(size(info_gains_matrix,1),size(info_gains_matrix,2));
    info_gain_stats = zeros(size(info_gains_matrix,1),4);
    
    for k=1:size(final_info_gains,1)
        for l = 1:size(final_info_gains,2)
            final_info_gains(k,l) = info_gains_matrix(find(ranked_attributes(:,l)==k,1),l);
        end
        
        info_gain_stats(k,:)=[mean(final_info_gains(k,:)), var(final_info_gains(k,:)), std(final_info_gains(k,:)), mad(final_info_gains(k,:),1)];
    end
    
    output = info_gain_stats;
end