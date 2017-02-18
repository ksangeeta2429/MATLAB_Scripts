function [feature_min, scalingFactors] = GetFeatureMinScalingFactorsArff(arff_file)

% arff_file = 'C:\Users\royd\Box Sync\All_programs_data_IPSN_2016\Simulation\toDhruboMichael\IIITDemo\Arff\royd\radar112016.arff';

import weka.attributeSelection.*;

instances = loadARFF(arff_file);

feature_min = zeros(1,instances.numAttributes()-1);
scalingFactors = zeros(1,instances.numAttributes()-1);

for i=0:instances.numAttributes()-2
    arr = instances.attributeToDoubleArray(i);
    max_col = max(arr);
    min_col = min(arr);
    
    if max_col~=min_col
        scalingFactors(i+1) = 1/(max_col-min_col);
    else
        scalingFactors(i+1) = 0;
    end
    feature_min(i+1) = min_col;
end
