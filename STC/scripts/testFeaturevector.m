% given a feature vector, apply the classifier on it and output the classification
% result

function [classLabel,decision] = testFeaturevector(f_file, SV_matlab, param,gamma,rho)
    decision=-rho;
    for i=1:length(param)
        decision = decision + param(i)*kernel(f_file,SV_matlab(i,:),gamma);
    end
    if (decision<0) 
        classLabel=0;
    else
        classLabel=1;
    end
end

function res = kernel(feature1,feature2,gamma)
    res = exp(-gamma*sum((feature1-feature2).^2));
end
