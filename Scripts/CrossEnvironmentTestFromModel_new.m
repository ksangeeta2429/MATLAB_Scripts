function [resultstr]=CrossEnvironmentTestFromModel_new(full_path_model,full_path_testset)
% Dummy values - to be commented post testing
% SetEnvironment
% SetPath
% full_path_model = '"C:\\Users\\Roy\\Box Sync\\All_programs_data_IPSN_2016\\Simulation\\toDhruboMichael\\IIITDemo\\Models\\E1_to_E5_scaled_combos\\radar1_scaled_nr.model"';
% full_path_testset = '"C:\\Users\\Roy\\Box Sync\\All_programs_data_IPSN_2016\\Simulation\\toDhruboMichael\\IIITDemo\\Arff\\E1_to_E5_scaled_combos\\nr\\test_envs\\radar1_scaled_nr.arff"';

%% Function body
type='functions.LibSVM';
options = sprintf('-l %s -T %s', full_path_model, full_path_testset);

import weka.classifiers.Evaluation;
import java.util.Random;
import weka.core.Utils.splitOptions;
import weka.functions.supportVector.*;
import weka.classifiers.functions.LibSVM; % need to add the path of the libsvm.jar to the class path, e.g. C:\Users\he\wekafiles\packages\LibSVM\libsvm.jar

classifier = javaObject(['weka.classifiers.',type]);
resultstr = Evaluation.evaluateModel(classifier,weka.core.Utils.splitOptions(options));