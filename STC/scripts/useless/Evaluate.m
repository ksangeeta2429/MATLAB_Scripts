%function Evaluate(OutIndex_train,OutIndex_test)

%root='C:/Users/heji/Dropbox/MyMatlabWork/';
root='C:/Documents and Settings/he/My Documents/Dropbox/MyMatlabWork/';
addpath([root,'radar/STC/scripts/matlab2weka']);
addpath([root,'radar/STC/scripts']);

%%%%%%%%%%%%%%%%%%%%% build model %%%%%%%%%%%%%%%%%%%%%%%%%%
OutIndex_train=5;
OutIndex_test=1;
ifReg=1;

import weka.classifiers.Evaluation;
import weka.core.Utils.splitOptions;
import weka.functions.supportVector.*;
import weka.core.Instance; 

if ifReg==0
    type='functions.SMO';
    options='-C 1.0 -L 0.0010 -P 1.0E-12 -N 0 -V -1 -W 1 -K "weka.classifiers.functions.supportVector.Puk -C 250007 -O 1.0 -S 1.0"';
else  % ifReg=1
    type='functions.SMOreg';
    options='-C 1.0 -N 0 -I "weka.classifiers.functions.supportVector.RegSMOImproved -L 0.0010 -W 1 -P 1.0E-12 -T 0.0010 -V" -K "weka.classifiers.functions.supportVector.Puk -C 250007 -O 1.0 -S 1.0"';
end

path_arff=[root,'radar/STC/arff files'];
cd(path_arff);
instances_train = loadARFF(sprintf('radar%d.arff',OutIndex_train));
classifier = javaObject(['weka.classifiers.',type]);
classifier.setOptions(weka.core.Utils.splitOptions(options));
classifier.buildClassifier(instances_train);

%%%%%%%%%%%%%%%%% test the model %%%%%%%%%%%%%%%%%%%%%%%%%%%
instances_test =loadARFF(sprintf('radar%d.arff',OutIndex_test));
eval = Evaluation(instances_train); %weka.classifiers.functions.SMOreg 
num_est=eval.evaluateModel(classifier,sprintf('-t radar%d.arff -T radar%d.arff -C 1.0 -N 0 -I "weka.classifiers.functions.supportVector.RegSMOImproved -L 0.0010 -W 1 -P 1.0E-12 -T 0.0010 -V" -K "weka.classifiers.functions.supportVector.Puk -C 250007 -O 1.0 -S 1.0"',OutIndex_train,OutIndex_test))
num_true=instances_test.attributeToDoubleArray(instances_test.classIndex()) 
instances_test.classIndex()
instances_test.numAttributes()

plotStat(num_true,num_est);



%        instance = Instance(length(f)+1);
%        for ii=1:length(f)
%            instance.setValue(ii-1, f(ii));
%        end
%        instance.setDataset(instances_train);
%        
%        % predict
%        eval = Evaluation(instances_train);
%        
%        numPeople=eval.evaluateModelOnce(classifier,instance) %AndRecordPrediction
