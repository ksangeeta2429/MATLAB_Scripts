% given a feature vector, apply the classifier on it and output the classification
% result

function [classLabel,decision] = testFeaturevector(f_file, SV_matlab, param,gamma,rho)
    
%     f_file=[232850.000000000,29.000000000,827.000000000,45.000000000,32.500000000,117.121551512,61.000000000,458.000000000,30.000000000,18.500000000,65.686149568,55.000000000];

    decision=-rho;
    for i=1:length(param)
        decision = decision + param(i)*kernel(f_file,SV_matlab(i,:),gamma);
    end
    % check C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\IIITDemo\Records\tmp.txt 
    % and see the weight to check the trained model is whether human positive or dog positive
    if (decision<0)  
        classLabel=0;
    else
        classLabel=1;
    end
end

function res = kernel(feature1,feature2,gamma)
    res = exp(-gamma*sum((feature1-feature2).^2));
end
