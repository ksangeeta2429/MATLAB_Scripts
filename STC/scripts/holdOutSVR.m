%given train and test data return predicted result for test instances

function [pred_result,eval] = holdOutSVR(train,test,type,options)
	
	import weka.classifiers.Evaluation;
	import weka.core.Instances;
	%disp(train.numInstances());
	%disp(test.numInstances());

	%use these 3 lines and eval.evaluateModel() for heldout testing
    svr = javaObject(['weka.classifiers.',type]);
    %svr = SMOreg();
    %SMOreg svr = new SMOreg();
    svr.setOptions(weka.core.Utils.splitOptions(options));
    svr.buildClassifier(train);
    eval = Evaluation(train);
    pred_result = eval.evaluateModel(svr,test, javaArray('java.lang.Object', 0));
end