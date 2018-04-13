%Use this script to evaluate SMOreg with multiple parameters
% written by neel
%do not forget to select small number of attributes to begin with

function [] = svr(arff_file,result_file,n_fold,ifScaling,heldout,percent)

import weka.classifiers.Evaluation;
import java.util.Random;
import weka.core.Utils.splitOptions;
import weka.functions.supportVector.*;
import weka.attributeSelection.AttributeSelection;
import weka.attributeSelection.PrincipalComponents;
import weka.classifiers.functions.SMOreg
import weka.core.Instances;

instances = loadARFF(arff_file);
disp('Instances loaded from arff file');
num_instances = instances.numInstances();
num_attributes = instances.numAttributes();
fprintf('Number of instances : %d\n',num_instances);
fprintf('Number of attributes : %d\n',num_attributes);


%hold out approach for testing
%percent = 60;
test_true_labels = [];
if(heldout == 1)
    disp('Heldout testing, splitting the input file for training and testing...')
    instances.randomize(javaObject('java.util.Random'));
    trainSize = round(num_instances * percent/ 100);
    testSize = num_instances - trainSize;
    train = javaObject('weka.core.Instances',instances,0,trainSize);
    %train.setClassIndex(train.numAttributes() - 1);
    test = javaObject('weka.core.Instances',instances, trainSize, testSize);
    %test.setClassIndex(test.numAttributes() - 1);
    classIndex = num_attributes-1;
    for i = 0:test.numInstances()-1 
        i_test = test.get(i);
        test_true_labels = [test_true_labels i_test.value(classIndex)];
    end
    test_true_labels;
    size(test_true_labels);
    xx = unique(test_true_labels);
    x = sort(test_true_labels);
    t = zeros(size(xx));
    for i = 1:length(xx)
        t(i) = sum(x == xx(i));
    end
    xx
    t
end

fd = fopen(result_file,'a');

cost = [0.1,1,10,100,200,1000,10000,100000];
o = [0.1,1,10,50,100,200,500];
s = [0.1,0.4,0.7,1,4,7,9,10,100,200,500];

cost = [0.1];
o = [50];
s = [0.1];

type = 'functions.SMOreg';
min_meanAbsError = 1;
best_omega = 0;
best_sigma = 0;
best_cost = 0;
error = [];
best_predictions = [];
best_result = '';
for c = cost
    for omega = o
        for sigma = s
            fprintf('\nC : %f Omega : %f  Sigma : %f\n',c,omega,sigma);
            options=sprintf('-C %d -N 0 -I "weka.classifiers.functions.supportVector.RegSMOImproved -L 0.0010 -W 1 -P 1.0E-12 -T 0.0010 -V" -K "weka.classifiers.functions.supportVector.Puk -C 250007 -O %d -S %d"',c,omega,sigma);
            
            if(heldout == 1)
                %use these 3 lines and eval.evaluateModel() for heldout testing
                svr = javaObject(['weka.classifiers.',type]);
                %svr = SMOreg();
                %SMOreg svr = new SMOreg();
                svr.setOptions(weka.core.Utils.splitOptions(options));
                svr.buildClassifier(train);
                eval = Evaluation(test);
                result = eval.evaluateModel(svr,test, javaArray('java.lang.Object', 0));
                size(result);
            else
                % use these 2 lines and eval.crossValidateModel() for cross validation
                classifier = javaObject(['weka.classifiers.',type]);
                classifier.setOptions(weka.core.Utils.splitOptions(options)); 
                eval = Evaluation(instances);
                eval.crossValidateModel(['weka.classifiers.',type],instances,n_fold,weka.core.Utils.splitOptions(options),Random(1)); % n-fold
            end             
            
            AE = zeros(1,length(unique(test_true_labels)));
            n_AE = zeros(1,length(unique(test_true_labels)));
            MAE = zeros(1,length(unique(test_true_labels)));
            N = length(test_true_labels);
            for i = 1:length(test_true_labels)
                AE(test_true_labels(i)) = AE(test_true_labels(i)) + abs(test_true_labels(i)-result(i));
                n_AE(test_true_labels(i)) = n_AE(test_true_labels(i)) + 1;
            end
            for i = 1:length(test_true_labels)
                MAE(test_true_labels(i)) = AE(test_true_labels(i)) / n_AE(test_true_labels(i));
            end
            disp('Absolute Error for each of the labels :')
            AE
            disp('Mean Absolute Error for each of the labels :')
            MAE
            fprintf('Absolute Error : %f\n',sum(AE));
            result=eval.toSummaryString('=========Results======', true);
            predictions = eval.predictions();
            A = toArray(predictions);
            for i = 1:length(A)
                if(A(i).predicted() >= 2)
                    A(i).actual()
                    A(i).predicted()
                    A(i).error()
                end
            end
            meanAbsError = eval.meanAbsoluteError();
            fprintf('meanAbsError : %f\n',meanAbsError);
            error = [error meanAbsError];
            if(min_meanAbsError > meanAbsError)
                min_meanAbsError = meanAbsError;
                best_cost = c; best_sigma = sigma; best_omega = omega;
                best_result = result;
                best_predictions = predictions;
                fprintf('Better result - meanAbsError : %f  C : %f  Omega : %f  Sigma : %f\n',min_meanAbsError,best_cost,best_omega,best_sigma)
                fprintf(fd,'--------------------------------\n');
                fprintf(fd,'%s\n',arff_file);
                fprintf(fd,datestr(datetime));
                fprintf(fd,'\n\nBest result : \n');
                fprintf(fd,'%s',best_result);
                fprintf(fd,'\nBest omega : %f\n',best_omega);
                fprintf(fd,'Best sigma : %f\n',best_sigma);
                fprintf(fd,'Best C : %f\n',best_cost);
                fprintf(fd,'--------------------------------\n');
            end
        end
    end
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

plot(error);
ylabel('Mean Absolute Error For differnt parameter settings');
xlabel('Number of combinations of parameters');
end