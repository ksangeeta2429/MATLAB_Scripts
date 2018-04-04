% how to test the regression function
% all file mentioned below is in the current folder:
% C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\STC\scripts\test\testRegressionFunction
% 
% 1. create a sample arff file -  test.arff
% 2. open weka, open this file
% 3. choose model file path and name -  svr.txt
%    chosse LibSVM
% 4. choose Use training set
% 5. click start
% 5. right click left bottom result - choose "Visualize classifier errors"
% 6. click save, save it to result.arff
% 7. open this file and take any row and copy it to this file as f_file,
%    and run and see if the result in the file and the running of this script (regressionResult)
%    are the same.
% after testing we see that all the three rows could give the correct result here. 

% SMOReg and epsilon-svr in libsvm, are giving the same result. however the
% SMOReg cannot output the model to a text file as in Libsvm, it only
% output in the weka window, this makes the transfermation from model to c#
% code extremely difficult, because if there are many support vectors then
% we have to record the index of them and the weights all by hand, and the
% Model2Matrix.m cannot be used. So I will only train a model in matlab and
% converted to c# code in very limited time, I guess no more than 3.

%%% 5/4/2015, svr function ????????????svr???????????

function regressionResult = testFeaturevectorRegression(f_file, SV_matlab, param,gamma,rho)
    f_file = [3 2 1];
    SV_matlab = [1 2 3;
                 2 3 4;
                 3 2 1];
%     gamma = 0.05;
    omega=0.1;
    sigma=200;
    
    rho = -4.5891;
    param = [+0.7325161359676855 -20.0 +19.267483864032315];

    regressionResult=-rho;
    for i=1:length(param)
%         regressionResult = regressionResult + param(i)*kernelRBF(f_file,SV_matlab(i,:),gamma);
        regressionResult = regressionResult + param(i)*kernelPUK(f_file,SV_matlab(i,:),omega,sigma);
    end
end

function res = kernelRBF(feature1,feature2,gamma)
    res = exp(-gamma*sum((feature1-feature2).^2));
end

function res = kernelPUK(feature1,feature2,omega,sigma)
    res = 1/( 1 + ( 2*sqrt( sum((feature1-feature2).^2) * (2^(1/omega)-1) ) / sigma )^2)^omega;
end