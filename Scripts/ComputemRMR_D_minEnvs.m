function selectedFeatures = ComputemRMR_D_minEnvs(k, path_to_arff)

import weka.attributeSelection.*;
import weka.filters.Filter;
import weka.filters.supervised.attribute.Discretize;
import weka.attributeSelection.userExtensions.CustomMIToolbox;

cd(path_to_arff);
Files = dir('*.arff');

if isempty(k)
        k=-1;
end

dataArr = javaArray('weka.core.Instances',length(Files));

for f=1:length(Files)
    fprintf('Processing file %s\n', Files(f).name);
    dataArr(f) = loadARFF(Files(f).name);
end

selectedFeatures = CustomMIToolbox.mRMR_D_minEnvs(k, dataArr)+1;