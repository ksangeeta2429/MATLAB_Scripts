% % Analyze noise sensitivity of each classification features
% train with the first half of data
% sweep  the rest
% if too wrong throw
% if one feature is too bad (almost not distinguishable) throw.
% Drop very noisy features
% % Mark data (frames) at run time in classifier
% % Discard useless data (frames) in classifier
% 

% 1.Initially, have a feature set, have a data set
% 2.Sweep all the features, measure the distribution on one feature,compute a factor, if below a threshold, throw this feature
% 3.Randomly choose 1/5 data    
% 4.Train with the current set of data and feature set.
% 5.Sweep 1/5 data
% 6.If data is too wrong, throw.
% 7.Go to 4
% Note: 5 is a parameter to adjust


% should run execute.m first, to train a model first, so that
% SV_matlab,param,gamma,rho,feature_min,scalingFactors are all generated

SetEnvironment
SetPath

import weka.classifiers.Evaluation;
import java.util.Random;
import weka.core.Utils.splitOptions;
import weka.functions.supportVector.*;
import weka.classifiers.functions.LibSVM;

%% INPUT:
thr=0.5;
path_data_human = 'C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\IIITDemo\Data\New\Controllable\Rest1\Human';
% path_data_dog ='C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\IIITDemo\Data\New\Controllable\Rest\Dog';
path_data_dog ='C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\IIITDemo\Data\New\Controllable\Dog';

%% COMPUTE:
%%%%%%%%%%%%%%%%%%%%%%%%%%% build f_set %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% human
class=0;
cd(path_data_human);
fileFullNames=dir;
Files={};  % first 2 file is '.' and '..'
i=1;
for j=1:length(fileFullNames)
    s=fileFullNames(j).name;
    k=strfind(s,'.data');
    if ~isempty(k) && k>=2 && k+4==length(s) % k+4==length(s) to avoid .data.emf file
        Files{i}=s(1:k-1);
        i=i+1;
    end
end
toDeleteHumanFiles = [];
nToDeleteHumanFiles = 0;
for i=1:length(Files) % take every file from the set 'Files'
    sprintf('%dth file is processing\n',i) % the i-th file is processing
    fileName=Files{i};
    [classLabel,decision] = testFile(fileName,feature_min,scalingFactors,SV_matlab, param,gamma,rho)
    if class~=classLabel && abs(decision)>thr
        toDeleteHumanFiles = [toDeleteHumanFiles, fileName,','];
        nToDeleteHumanFiles = nToDeleteHumanFiles+1;
    end
end

sprintf('the total num of human files is: %d',length(Files))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% dog
class=1;
cd(path_data_dog);
fileFullNames=dir;
Files={};  % first 2 file is '.' and '..'
i=1;
for j=1:length(fileFullNames)
    s=fileFullNames(j).name;
    k=strfind(s,'.data');
    if ~isempty(k) && k>=2 && k+4==length(s) % k+4==length(s) to avoid .data.emf file
        Files{i}=s(1:k-1);
        i=i+1;
    end
end
toDeleteDogFiles = [];
nToDeleteDogFiles = 0;
for i=1:length(Files) % take every file from the set 'Files'
    sprintf('%dth file is processing\n',i) % the i-th file is processing
    fileName=Files{i};
    [classLabel,decision] = testFile(fileName,feature_min,scalingFactors,SV_matlab, param,gamma,rho)
    if class~=classLabel && abs(decision)>thr
        toDeleteDogFiles = [toDeleteDogFiles, fileName,','];
        nToDeleteDogFiles = nToDeleteDogFiles+1;
    end
end
sprintf('the total num of dog files is: %d',length(Files))
nToDeleteHumanFiles
toDeleteHumanFiles
nToDeleteDogFiles
toDeleteDogFiles