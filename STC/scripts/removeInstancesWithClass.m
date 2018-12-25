function [filtered] = removeInstancesWithClass(class_to_remove,data)

	import weka.core.Instances;

	filtered = Instances(data,0);
	for i = 1:data.numInstances()
		inst = data.instance(i);
		if(ismember(inst.value(inst.classIndex()),class_to_remove))
			filtered.add(inst);
		end
	end	
	
end