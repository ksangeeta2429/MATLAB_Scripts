function Evaluate_1(OutIndex_train,OutIndex_test)
%chunk evaluate

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
num_true=instances_test.attributeToDoubleArray(instances_test.classIndex());
nInst=instances_test.numInstances();
num_est=zeros(nInst,1);

num_est_chunk=zeros(floor(nInst/5),1);
num_true_chunk=zeros(floor(nInst/5),1);

eval = Evaluation(instances_train);
for i=1:nInst
    instance=instances_test.instance(i-1); 
    num_est(i)=eval.evaluateModelOnce(classifier,instance);
    if i>=3 && mod(i,5)==3 && i<=nInst-2 && num_true(i-2)==num_true(i) && num_true(i-1)==num_true(i) && num_true(i+1)==num_true(i) && num_true(i+2)==num_true(i)
 %        num_est_chunk(ceil(i/5))=mode(round(num_est(i-2:i+2)));
         num_est_chunk(ceil(i/5))=mean(num_est(i-2:i+2));
 %        num_est_chunk(ceil(i/5))=median(num_est(i-2:i+2));
         num_true_chunk(ceil(i/5))=num_true(i);
    end
end
plotStat(num_true_chunk,num_est_chunk);

%     if number(i-1)==number(i) && number(i)==number(i+1)
%         number_pred(i)=(number_pred(i-1)+number_pred(i)+number_pred(i+1))/3;
%     end
% end

       
       



