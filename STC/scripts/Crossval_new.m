% input: index of data set
% do: cross validation

function [meanAbsError result confusionmatrix]=Crossval_new(root, OutIndex,ifReg,c,omega,sigma,path_arff)       % used when trim data is used. Crossval is used when all the data is used(do not let frames in the same file showing in both training and testing set)
%addpath([root,'radar/STC/scripts/matlab2weka']);
%addpath([root,'radar/STC/scripts']);


%OutIndex=11;
%ifReg=1;

if ifReg==0
    type='functions.SMO';
    options=sprintf('-C %d -L 0.0010 -P 1.0E-12 -N 0 -V -1 -W 1 -K "weka.classifiers.functions.supportVector.Puk -C 250007 -O %d -S %d"',c,omega,sigma);
else  % ifReg=1
    type='functions.SMOreg';
    options=sprintf('-C %d -N 0 -I "weka.classifiers.functions.supportVector.RegSMOImproved -L 0.0010 -W 1 -P 1.0E-12 -T 0.0010 -V" -K "weka.classifiers.functions.supportVector.Puk -C 250007 -O %d -S %d"',c,omega,sigma);
end



import weka.classifiers.Evaluation;
import java.util.Random;
import weka.core.Utils.splitOptions;
import weka.functions.supportVector.*;
import weka.attributeSelection.AttributeSelection;
import weka.attributeSelection.PrincipalComponents;

%path_arff=[root,'radar/STC/arff files'];
cd(path_arff);
instances = loadARFF(sprintf('radar%d.arff',OutIndex));
%instances = loadARFF(sprintf('586_humans_700+humans_counting_frame_length_is_cut_length_20_features_CorrelationAttEval.arff'));
disp('Instances loaded from arff file');
classifier = javaObject(['weka.classifiers.',type]);
classifier.setOptions(weka.core.Utils.splitOptions(options));

disp('Starting Evaluation');
eval = Evaluation(instances);
eval.crossValidateModel(['weka.classifiers.',type],instances,10,weka.core.Utils.splitOptions(options),Random(1)); % 10-fold
result=eval.toSummaryString('=========Results======', true);
disp('Evaluation done');
meanAbsError = eval.meanAbsoluteError();
if ifReg==0
    confusionmatrix=eval.confusionMatrix();
else
    confusionmatrix=[];
end
