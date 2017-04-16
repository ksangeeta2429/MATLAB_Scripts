function [model_outpath, avg_accuracy]=Crossenv_val_new(path_models,path_single_envs, path_combined_env,c, gamma, generate_model)
%% Function body
% Get combined environment name
cd(path_combined_env);
combEnvFile=dir('*.arff');
combEnv = combEnvFile(1).name;

% Extract feature string
features_csv = strrep(combEnv(strfind(combEnv,'_f_')+3:strfind(combEnv,'.arff')-1),'_',',');

cd(path_single_envs);
singleEnvFiles = dir('*.arff');

SingleEnvs = cell(1,length(singleEnvFiles));
for j=1:length(singleEnvFiles)
    SingleEnvs{j} = singleEnvFiles(j).name;
end

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

if generate_model==1
    instances=loadARFF(strcat(path_combined_env,'/',combEnv));
    classifier = javaObject(['weka.classifiers.',type]);
    classifier.setOptions(weka.core.Utils.splitOptions(options));
    classifier.buildClassifier(instances);
    weka.core.SerializationHelper.write(model_outpath,classifier);
    return
end

accuracy = zeros(1,length(SingleEnvs));

for i=1:length(SingleEnvs)
    %N-1/1 split
    testFile = SingleEnvs{i};
    trainFiles = setdiff(SingleEnvs,testFile);
    
    % load test instance
    testInstance = loadARFF(testFile);
    
    % combine training instances
    trainInstance = loadARFF(trainFiles{1});
    for l=2:length(trainFiles)
        trainInstance.addAll(loadARFF(trainFiles{l}));
    end
    
    % Filter training and test sets
    trainInstance_filtered = AttributeSelectionManual_Instances(trainInstance, features_csv);
    testInstance_filtered = AttributeSelectionManual_Instances(testInstance, features_csv);
    
    accuracy(i) = CustomMIToolbox.evaluateSVM(trainInstance_filtered, testInstance_filtered, c, gamma);
    
%     classifier = javaObject(['weka.classifiers.',type]);
%     classifier.setOptions(weka.core.Utils.splitOptions(options));
%     classifier.buildClassifier(trainInstance_filtered);
%     
% %     if generate_model==1
% %         weka.core.SerializationHelper.write(model_outpath,classifier);
% %     end
%     
%     eval = Evaluation(trainInstance_filtered);
%     eval.evaluateModel(classifier,testInstance_filtered,javaObject('java.lang.Object',[]));
%     
%     switch lower(return_type)
%         case 'precision'
%             return_value(i) = eval.precision(compIndex);
%         case 'recall'
%             return_value(i) = eval.recall(compIndex);
%         case 'truepositiverate'
%             return_value(i) = eval.numTruePositives(compIndex);
%         case 'falsepositiverate'
%             return_value(i) = eval.numTruePositives(compIndex);
%         case 'truenegativerate'
%             return_value(i) = eval.numTrueNegatives(compIndex);
%         case 'falsenegativerate'
%             return_value(i) = eval.numFalseNegatives(compIndex);
%         otherwise
%             return_value(i)=eval.pctCorrect(); % default: accuracy
%     end
end
avg_accuracy = mean(accuracy);
