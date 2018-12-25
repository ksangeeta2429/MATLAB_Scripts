%Use this script to evaluate SMOreg with multiple parameters
% written by neel
%do not forget to select small number of attributes to begin with

%function [] = svr(arff_file,result_file,n_fold,heldout,percent,train_error,train_result_file,rounded_error,plot_errors)

SetEnvironment;
SetPath;

%{
%foll 4 lines only required to run on OSC
addpath(genpath('/users/PAS1090/osu10640/box.com/MATLAB_Scripts/STC/'));
dpath = {'/users/PAS1090/osu10640/box.com/MATLAB_Scripts/JAR_files/weka.jar'};
javaclasspath('-v1');
javaclasspath(dpath);
%}

import weka.classifiers.Evaluation;
import java.util.Random;
import weka.core.Utils.splitOptions;
import weka.functions.supportVector.*;
import weka.attributeSelection.AttributeSelection;
import weka.attributeSelection.PrincipalComponents;
import weka.classifiers.functions.SMOreg
import weka.core.Instances;
import weka.classifiers.evaluation.NumericPrediction;


%variables to set
subfolder = '/final_bike_full_cuts/'
arff_file = strcat(g_str_pathbase_data,subfolder,'632_f.arff');
result_file = strcat(g_str_pathbase_data,subfolder,'counting/svr.txt');
if(~exist(strcat(g_str_pathbase_data,subfolder,'counting/'),'dir') ~= 7)
    mkdir(strcat(g_str_pathbase_data,subfolder,'counting/'));
    fprintf('INFO: created directory %s\n', strcat(g_str_pathbase_data,subfolder,'counting/'));
end
%if there is not enough data for a particular label remove from training
class_to_remove = [5,6]; 
seed = 0; train_error = 0; train_result_file = '';
rounded_error = 1; plot_errors = 0;
heldout = 0; percent = 70;
n_fold = 10;
perc = 70;
RBF = 0; PEARSON = 1;


instances = loadARFF(arff_file);
instances.randomize(javaObject('java.util.Random'));
fprintf('Instances loaded from arff file\n');
printInstancesDetails(instances);

classIndex = instances.numAttributes()-2;
fprintf('\nSetting attribute %s as class label',instances.attribute(classIndex).name());
instances.setClassIndex(classIndex);

fprintf('\nDeleting attribute %s\n',instances.attribute(instances.numAttributes()-1).name());
instances.deleteAttributeAt(instances.numAttributes()-1); %delete class label
printInstancesDetails(instances);

%instances = removeInstancesWithClass(class_to_remove,instances);
%fprintf('Class labels of Instances removed : \n');
%disp(class_to_remove);
%printInstancesDetails(instances);
%instances = balanceInstances(instances,seed,perc);
%disp('Instances balanced\n');
%printInstancesDetails(instances);
num_instances = instances.numInstances();
num_attributes = instances.numAttributes();
fprintf('\nNumber of instances : %d\n',num_instances);
fprintf('Number of attributes : %d\n',num_attributes);

if(train_error == 1)
    %use entire set for training and testing to get train error. This is the upper bound 
    %on performance
    entire_train_set = instances;
    entire_set_true_labels = labelsFromInstances(entire_train_set,classIndex);
    [xx_train,t_train] = labelCounts(entire_set_true_labels)
end

%hold out approach for testing
%percent = 60;
test_true_labels = [];
if(heldout == 1)
    disp('Heldout testing, splitting the input file for training and testing...')
    [train,test] = holdOut(instances,percent);
    test_true_labels = labelsFromInstances(test,classIndex);
    train_true_labels = labelsFromInstances(train,classIndex);
    %xx is distinct count labels in the test instances and t is the corresponding 
    %number of those labels in test instances.
    [xx,t] = labelCounts(test_true_labels);   
end

fd = fopen(result_file,'a');

%cost = [0.01,0.1,1,10,100,200,1000,10000,100000];
%o = [0.1,1,3,5,7,10,50,100,200,500];
%s = [0.1,0.4,0.7,1,4,7,9,10,100,200,500];
%g = [0.0625,0.125,0.25,0.5,1,2,4,8,16,32,64,128,256];
cost = [10];
o = [0.1];
s = [0.1];

type = 'functions.SMOreg';
min_meanAbsError = 1;
best_omega = 0; best_sigma = 0; best_cost = 0; best_gamma = 0;
error = [];
best_predictions = []; best_result = '';
best_train_error = 1; best_train_c = 0; best_train_omega = 0; best_train_sigma = 0; best_train_gamma = 0;
for c = cost
    for omega = o
        for sigma = s
        %for gamma = g
            options = '';
            if(RBF == 1)
                options=sprintf('-C %d -N 0 -I "weka.classifiers.functions.supportVector.RegSMOImproved -L 0.0010 -W 1 -P 1.0E-12 -T 0.0010 -V" -K "weka.classifiers.functions.supportVector.RBFKernel -C 250007 -G %d"',c,gamma);
                fprintf('\nC : %f Gamma : %f\n',c,gamma);
            elseif(PEARSON == 1)
                options=sprintf('-C %d -N 0 -I "weka.classifiers.functions.supportVector.RegSMOImproved -L 0.0010 -W 1 -P 1.0E-12 -T 0.0010 -V" -K "weka.classifiers.functions.supportVector.Puk -C 250007 -O %d -S %d"',c,omega,sigma);
                fprintf('\nC : %f Omega : %f  Sigma : %f\n',c,omega,sigma);
            end
            if(heldout == 1)
                [pred_result,eval] = holdOutSVR(train,test,type,options);
                size(pred_result);
            else
                % use these 2 lines and eval.crossValidateModel() for cross validation
                classifier = javaObject(['weka.classifiers.',type]);
                classifier.setOptions(weka.core.Utils.splitOptions(options)); 
                eval = Evaluation(instances);
                eval.crossValidateModel(['weka.classifiers.',type],instances,n_fold,weka.core.Utils.splitOptions(options),Random(1)); % n-fold
            end         

            if(train_error == 1)
                train_fd = fopen(train_result_file,'a');
                [train_predictions,entire_set_eval] = holdOutSVR(entire_train_set,entire_train_set,type,options);
                entire_set_true_labels(550:600);
                a = train_predictions;
                a(550:600);
                [AE_rounded,MAE_rounded,AE,MAE,train_meanAbsError,train_meanAbsError_rounded] = absoluteAndMeanError(entire_set_true_labels,train_predictions,rounded_error);
                %disp('Train Error : ');
                %train_meanAbsError = entire_set_eval.meanAbsoluteError();
                MAE;
                if(train_meanAbsError_rounded < best_train_error)
                    best_train_error = train_meanAbsError_rounded;
                    best_train_c = c; 
                    best_train_result = entire_set_eval.toSummaryString('=========Results======', true);

                    fprintf('Better result - meanAbsError : %f  C : %f  Omega : %f  Sigma : %f\n',best_train_error,best_train_c,best_train_omega,best_train_sigma);
                    fprintf(train_fd,'--------------------------------\n');
                    fprintf(train_fd,'%s\n',arff_file);
                    fprintf(train_fd,datestr(datetime));
                    fprintf(train_fd,'\nCount Label statistics : (Count : number AE MAE)\n');
                    
                    if(rounded_error == 1)
                        fprintf(train_fd,'\nRounded Train Error :\n');
                        for i = 1:length(xx_train)
                            fprintf(train_fd,'%d : %d  %f  %f\t',xx_train(i),t_train(i),AE_rounded(i),MAE_rounded(i));
                        end
                        fprintf(train_fd,'\n\nRounded Train Mean Absolute Error : %f\n',train_meanAbsError_rounded);
                        %fprintf('\nRounded Train Mean Absolute Error : %f\n',train_meanAbsError_rounded);
                    end
                    fprintf(train_fd,'\nTrain Error :\n');
                    for i = 1:length(xx_train)
                        fprintf(train_fd,'%d : %d  %f  %f\t',xx_train(i),t_train(i),AE(i),MAE(i));
                    end
                    fprintf(train_fd,'\n\nTrain Mean Absolute Error : %f\n',train_meanAbsError);
                    fprintf(train_fd,'\n\nBest result : \n');
                    fprintf(train_fd,'%s',best_train_result);
                    
                    if(RBF == 1)
                        best_train_gamma = gamma;
                        fprintf(train_fd,'\nBest gamma : %f\n',best_train_gamma);
                    elseif(PEARSON == 1)
                        best_train_omega = omega; best_train_sigma = sigma;
                        fprintf(train_fd,'\nBest omega : %f\n',best_train_omega);
                        fprintf(train_fd,'Best sigma : %f\n',best_train_sigma);
                    end
                    fprintf(train_fd,'Best C : %f\n',best_train_c);
                    fprintf(train_fd,'--------------------------------\n');
                end
            end
            
            result = eval.toSummaryString('=========Results======', true);    
            disp(result);
            conf_mat = eval.toMatrixString();
            disp(conf_mat);
            
            %disp(round(train_predictions));

            if(heldout == 1)
            
            [AE_rounded,MAE_rounded,AE,MAE,mAbsErr,mAbsErr_rounded] = absoluteAndMeanError(test_true_labels,pred_result,rounded_error);

            %disp('Absolute Error for each of the labels :')
            AE;
            %disp('Mean Absolute Error for each of the test labels :')
            MAE;
            %fprintf('Absolute Error : %f\n',sum(AE));
            end
  
            predictions = eval.predictions();
            A = toArray(predictions);
            %assuming 
            %{
            %c = zeros(1,length(unique(test_true_labels)));
            %for i = 1:length(xx)
              %  for j = 1:length(A)
                    %if(A.actual() == i)
                  %      %temp(i) = [temp(i),A.predict()];
                   % end
               % end
           % end
            %}
            meanAbsError = eval.meanAbsoluteError();
            fprintf('Hold out testing meanAbsError : %f\n',meanAbsError);
            error = [error meanAbsError];
            if(min_meanAbsError > mAbsErr_rounded)
                min_meanAbsError = mAbsErr_rounded;
                best_cost = c; 
                best_result = result;
                best_predictions = predictions;
                
                fprintf('Better result - meanAbsError : %f  C : %f  Omega : %f  Sigma : %f\n',min_meanAbsError,best_cost,best_omega,best_sigma)
                fprintf(fd,'--------------------------------\n');
                fprintf(fd,'%s\n',arff_file);
                fprintf(fd,datestr(datetime));
                if(heldout == 1)
                    fprintf(fd,'\nCount Label statistics : (Count : number AE MAE)\n');
                    if(rounded_error == 1)
                        fprintf(fd,'\nRounded Error :\n');
                        for i = 1:length(xx)
                            fprintf(fd,'%d : %d  %f  %f\t',xx(i),t(i),AE_rounded(i),MAE_rounded(i));
                        end
                        fprintf(fd,'\n\nRounded Mean Absolute Error : %f\n',mAbsErr_rounded);    
                    end
                    fprintf(fd,'\nError :\n');
                    for i = 1:length(xx)
                        fprintf(fd,'%d : %d  %f  %f\t',xx(i),t(i),AE(i),MAE(i));
                    end
                    fprintf(fd,'\n\nMean Absolute Error : %f\n',mAbsErr);
                end
                fprintf(fd,'\n\nBest result : \n');
                fprintf(fd,'%s',best_result);
                if(RBF == 1)
                    best_gamma = gamma;
                    fprintf(fd,'\nBest gamma : %f\n',best_gamma);
                elseif(PEARSON == 1)
                    best_sigma = sigma; best_omega = omega;
                    fprintf(fd,'\nBest omega : %f\n',best_omega);
                    fprintf(fd,'Best sigma : %f\n',best_sigma);
                end
                fprintf(fd,'Best C : %f\n',best_cost);
                fprintf(fd,'--------------------------------\n');
            end
        end
    end
end

if(train_error == 1)
    fprintf('Train MAE : %f Best Train C : %f Best Train Omega : %f Best Train Sigma : %f\n',train_meanAbsError,best_train_c,best_train_omega,best_train_sigma)
end

%{
fprintf(fd,'--------------------------------\n');
fprintf(fd,'%s\n',arff_file);
fprintf(fd,datestr(datetime));
fprintf(fd,'\n\nBest result : \n');
fprintf(fd,'%s',best_result);
fprintf(fd,'\nBest omega : %f\n',best_omega);
fprintf(fd,'Best sigma : %f\n',best_sigma);
fprintf(fd,'Best C : %f\n',best_cost);
fprintf(fd,'--------------------------------\n');
%}

if(plot_errors == 1)
    plot(error);
    ylabel('Mean Absolute Error For differnt parameter settings');
    xlabel('Number of combinations of parameters');
end

%end