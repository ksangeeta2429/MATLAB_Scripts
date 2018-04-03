% given a file, apply the classifier on it and output the classification
% result

function [classLabel,decision] = testFile(fileName,feature_min, scalingFactors,SV_matlab, param,gamma,rho)
addpath('C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\IIITDemo\Scripts');
addpath('C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\STC\scripts\matlab2weka');
addpath('C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\IIITDemo\MatlabLibrary');


f_file=File2Feature(fileName, 'Human', 1, 0, feature_min, scalingFactors);
f_file = f_file(1:length(f_file)-1);
f_file = cell2mat(f_file);
[classLabel,decision] = testFeaturevector(f_file, SV_matlab, param,gamma,rho);
