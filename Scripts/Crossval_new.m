function [model_outpath, accuracy, result, confusionmatrix]=Crossval_new(path_models,full_arff_folder,fileName, c, gamma, generate_model)       % used when trim data is used. Crossval is used when all the data is used(do not let frames in the same file showing in both training and testing set)
%% Dummy values - to be commented post testing
% SetEnvironment
% SetPath
% c=100000;
% gamma=0.1;
% g_str_pathbase_model='C:\\Users\\DL287WIN1\\Desktop\\WekaTest';
% full_arff_folder = 'C:\\Users\\DL287WIN1\\Desktop\\WekaTest';
% fileName = 'radar1_scaled_nr';
% generate_model=0;

%% Function body
type='functions.LibSVM';
%model_outpath = sprintf('"%s\\human_dog_model%d.model"',g_str_pathbase_model,OutIndex);
model_outpath = sprintf('%s/%s_p_%s_%s.model',path_models,fileName,num2str(c),num2str(gamma));
options=sprintf('-S 0 -K 2 -D 3 -G %d -R 0.0 -N 0.5 -M 40.0 -C %d -E 0.001 -P 0.1 -W "1.0 1.0" -seed 1',gamma,c);

% import weka.classifiers.Evaluation;
import weka.classifiers.*;
import java.util.Random;
% import weka.core.Utils.splitOptions;
import weka.core.Utils.*;
import weka.functions.supportVector.*;
% import weka.core.SerializationHelper;
import weka.core.*;
% import weka.classifiers.functions.LibSVM; % need to add the path of the libsvm.jar to the class path, e.g. C:\Users\he\wekafiles\packages\LibSVM\libsvm.jar
import weka.classifiers.functions.*;

%instances = loadARFF(sprintf('%s\\%s',full_arff_folder,[fileName,'.arff']));
instances = loadARFF(sprintf('%s/%s',full_arff_folder,[fileName,'.arff']));

if generate_model==1
    classifier = javaObject(['weka.classifiers.',type]);
    classifier.setOptions(weka.core.Utils.splitOptions(options));
    classifier.buildClassifier(instances);
    weka.core.SerializationHelper.write(model_outpath,classifier);
end

%classifier.setModelFile(sprintf('C:\\Users\\Roy\\human_dog_model%d.model',OutIndex));

eval = Evaluation(instances);
evalc('eval.crossValidateModel([''weka.classifiers.'',type],instances,10,weka.core.Utils.splitOptions(options),Random(1))'); %Suppress super-annoying output
%eval.crossValidateModel(classifier,instances,10,weka.core.Utils.splitOptions(options),Random(1)); % 10-fold

result=eval.toSummaryString('=========Results======', true);
accuracy=eval.pctCorrect();
confusionmatrix=eval.confusionMatrix();
