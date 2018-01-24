function [feature_min, scalingFactors] = UnscaledToScaledArff(unscaled_arff_file)
%% Test arguments
% unscaled_arff_file = 'C:\Users\royd\Box Sync\All_programs_data_IPSN_2016\Simulation\toDhruboMichael\IIITDemo\Arff\combined\radarALL_e_1_4_5_6_7_8_9_11_f_17_34_22_21_24_59_64_66_19_18_26_44.arff';

%% Function body
file_suffix = unscaled_arff_file(strfind(unscaled_arff_file,'_e_'):end);

import weka.attributeSelection.*;
instances = loadARFF(unscaled_arff_file);

nColumn=instances.numAttributes();
featureNames=cell(1,nColumn);
for i=0:nColumn-1
    featureNames{i+1}= instances.attribute(i).name();
end

feature_min = zeros(1,instances.numAttributes()-1);
feature_max = zeros(1,instances.numAttributes()-1);
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
    feature_max(i+1) = max_col;
end

f_set_scaled = [];
for i=0:instances.numInstances()-1
    curr_f_set = instances.get(i).toDoubleArray();
    
    if instances.get(i).classValue()==1
        classLabel = 'Human';
    else
        classLabel = 'Dog';
    end
    
    curr_f_set_scaled = curr_f_set(1:end-1)';
    curr_f_set_scaled = (curr_f_set_scaled-feature_min).*scalingFactors;
    
    f_file=[num2cell(curr_f_set_scaled),classLabel];
    
    f_set_scaled = [f_set_scaled;f_file];
end

ifReg=0;
instances=matlab2weka(instances.relationName(),featureNames,f_set_scaled,nColumn,ifReg);

saveARFF(strcat('C:\Users\roy.174\Box Sync\All_programs_data_IPSN_2016\Simulation\toDhruboMichael\IIITDemo\Arff\combined\radarALL_scaled',file_suffix), instances);

