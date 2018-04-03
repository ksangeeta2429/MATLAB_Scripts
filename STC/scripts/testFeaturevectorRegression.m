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

function regressionResult = testFeaturevectorRegression(f_file, SV_matlab, param,gamma,rho)
%     f_file = [2 3 4];
%     SV_matlab = [2 3 4;
%                  3 2 1];
%     gamma = 0.3333333333333333;
%     rho = -4.298395998775959;
%     param = [-1 1];

    regressionResult=-rho;
    for i=1:length(param)
        regressionResult = regressionResult + param(i)*kernel(f_file,SV_matlab(i,:),gamma);
    end
end

function res = kernel(feature1,feature2,gamma)
    res = exp(-gamma*sum((feature1-feature2).^2));
end