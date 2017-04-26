function accuracy_arr=CrossVal_10foldstats_new(path_models,path_combined_env,c, gamma, generate_model)
%% Function body
% Get combined environment name
cd(path_combined_env);
combEnvFile=dir('*.arff');
combEnv = combEnvFile(1).name;

type='functions.LibSVM';
%model_outpath = sprintf('"%s\\human_dog_model%d.model"',g_str_pathbase_model,OutIndex);
model_outpath = sprintf('%s/%s_p_%s_%s.model',path_models,combEnv(1:strfind(combEnv,'.arff')-1),num2str(c),num2str(gamma));
options=sprintf('-S 0 -K 2 -D 3 -G %d -R 0.0 -N 0.5 -M 40.0 -C %d -E 0.001 -P 0.1 -W "1.0 1.0" -seed 1',gamma,c);

% import weka.classifiers.Evaluation;
import weka.classifiers.*;
import java.util.Random;
import weka.functions.supportVector.*;
% import weka.core.SerializationHelper;
import weka.core.*;
% import weka.classifiers.functions.LibSVM; % need to add the path of the libsvm.jar to the class path, e.g. C:\Users\he\wekafiles\packages\LibSVM\libsvm.jar
import weka.classifiers.functions.*;
import weka.attributeSelection.userExtensions.CustomMIToolbox;

instances = loadARFF(combEnv);

if generate_model==1
    classifier = javaObject(['weka.classifiers.',type]);
    classifier.setOptions(weka.core.Utils.splitOptions(options));
    classifier.buildClassifier(instances);
    weka.core.SerializationHelper.write(model_outpath,classifier);
end

accuracy_arr = (CustomMIToolbox.crossValidateFoldStats(['weka.classifiers.',type],instances,10,weka.core.Utils.splitOptions(options),Random(1)))';
    