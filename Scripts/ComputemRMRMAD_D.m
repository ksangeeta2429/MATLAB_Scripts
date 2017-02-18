function [selectedFeatures, file_processing_order] = ComputemRMRMAD_D(k, path_to_arff, alpha, variance_scores)

import weka.attributeSelection.*;
import weka.filters.Filter;
import weka.filters.supervised.attribute.Discretize;
import weka.attributeSelection.userExtensions.CustomMIToolbox;

cd(path_to_arff);
Files = dir('*.arff');

for f=1:length(Files)
    fprintf('Processing file %s\n', Files(f).name);
    data = loadARFF(Files(f).name);
    if isempty(k)
        k=-1;
    end
    file_processing_order{f} = Files(f).name;
    selectedFeatures(:,f) = CustomMIToolbox.mRMRMAD_D(k, data, alpha, variance_scores)+1;
end