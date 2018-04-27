%use this script to balance instances with respect to a label

function [instances] = balanceInstances(arff_file,label)

import weka.core.Instances;

instances = loadARFF(arff_file);
att_index = instances.numAttributes()-1;
distinct_values = instances.numDistinctValues(att_index);
instances.sort(att_index);

for i = 0:instances.numInstances()-1
	i_instance = instances.get(i);
    true_label = i_instance.value(att_index);
    label_count(i_instance.value(att_index)) = 0;
end

true_labels = [];
for i = 0:instances.numInstances()-1
	i_instance = instances.get(i);
    true_labels = [true_labels i_instance.value(att_index)];
    label_count(i_instance.value(att_index)) = label_count(i_instance.value(att_index)) + 1;
end

number = label_count(label); %balance with respect to label : "number"
running_label_count = zeros(1,length(label_count));
for i = 0:instances.numInstances()-1 
	i_instance = instances.get(i);
    true_label = i_instance.value(att_index);
    running_label_count(true_label) = running_label_count(true_label) + 1;
    for j = 1:length(label_count)
    	if(running_label_count(j) > number)

end
end