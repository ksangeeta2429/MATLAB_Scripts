% input: index of data set for train, index of data set for test
% do: train a svm on set1 and test on set2

%function [result confusionmatrix]=TrainTest(OutIndex_train,OutIndex_test,ifReg)

OutIndex_train=8;
OutIndex_test=0;
ifReg=1;

if ifReg==0
    type='functions.SMO';
    options='-C 1.0 -L 0.0010 -P 1.0E-12 -N 0 -V -1 -W 1 -K "weka.classifiers.functions.supportVector.Puk -C 250007 -O 1.0 -S 1.0"';
else  % ifReg=1
    type='functions.SMOreg';
    options='-C 1.0 -N 0 -I "weka.classifiers.functions.supportVector.RegSMOImproved -L 0.0010 -W 1 -P 1.0E-12 -T 0.0010 -V" -K "weka.classifiers.functions.supportVector.Puk -C 250007 -O 1.0 -S 1.0"';
end

import weka.classifiers.Evaluation;
import java.util.Random;
import weka.core.Utils.splitOptions;
import weka.functions.supportVector.*;

addpath('matlab2weka');
instances_train = loadARFF(sprintf('../arff files/radar%d.arff',OutIndex_train));
instances_test = loadARFF(sprintf('../arff files/radar%d.arff',OutIndex_test));

classifier = javaObject(['weka.classifiers.',type]);
%classifier.setOptions(weka.core.Utils.splitOptions(options));
%classifier.buildClassifier(instances_train);

eval = Evaluation(instances_train);
options1=sprintf('-t "../arff files/radar%d.arff" -T "../arff files/radar%d.arff"',OutIndex_train,OutIndex_test);
eval.evaluateModel(classifier, weka.core.Utils.splitOptions([options,options1]))       
%result=eval.toSummaryString('=========Results======', true)

if ifReg==0
    confusionmatrix=eval.confusionMatrix();
else
    confusionmatrix=[];
end