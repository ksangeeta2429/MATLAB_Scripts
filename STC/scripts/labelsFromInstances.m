%given the instances and class/count label index return an array with all the labels

function true_labels = labelsFromInstances(instances,classIndex)

import weka.core.Instances;

true_labels = zeros(1,instances.numInstances());
for i = 0:instances.numInstances()-1 
    i_instances = instances.get(i);
    true_labels(i+1) = i_instances.value(classIndex);
end

end