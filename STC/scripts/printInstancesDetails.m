function printInstancesDetails(data)
import weka.core.Instances;

	fprintf('Num of attributes : %d\n',data.numAttributes());
	fprintf('Num of Instances : %d\n',data.numInstances());
	fprintf('Class Index : %d\n',data.classIndex());
	fprintf('Num of classes : %d\n',data.numClasses());
end