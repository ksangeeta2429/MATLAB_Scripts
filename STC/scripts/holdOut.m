%This script splits the instances into train and test datasets based on percentage train size
%input : instances to split and percentage of instances used for training
%output : train and test instances
%written by neel

function [train,test] = holdOut(instances,percent)
	
	import weka.core.Instances;
	import java.util.Random;

	instances.randomize(javaObject('java.util.Random'));
    trainSize = round(instances.numInstances() * percent/ 100);
    testSize = instances.numInstances() - trainSize;
    train = javaObject('weka.core.Instances',instances,0,trainSize);
    %train.setClassIndex(train.numAttributes() - 1);
    test = javaObject('weka.core.Instances',instances, trainSize, testSize);
    %test.setClassIndex(test.numAttributes() - 1);
end