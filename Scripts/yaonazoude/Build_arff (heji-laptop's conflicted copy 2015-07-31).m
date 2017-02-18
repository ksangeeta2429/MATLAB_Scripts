function [feature_min, scalingFactors] = Build_arff(OutIndex, ifScaled, featureClass, feature_min, scalingFactors)

%OutIndex = 5;
%ifScaled = 1;

addpath('C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\STC\scripts\matlab2weka');
addpath('C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\IIITDemo\Scripts');
addpath('C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\IIITDemo\Features');
addpath('C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\IIITDemo\Features\VelocityBased');
addpath('C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\IIITDemo\Features\PhaseBased');
addpath('C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\IIITDemo\Features\FftBased');
addpath('C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\IIITDemo\Features\AcclnBased');
addpath('C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\IIITDemo\MatlabLibrary');



% path_data_human = 'C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\IIITDemo\Data\New\Human\cut';
% path_data_dog = 'C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\IIITDemo\Data\New\Dog\cut';

% C:\Users\he\My Research\2014.8\20141028-arc  contains the 64 data that is
% very clean but not controllable
% C:\Users\he\My Research\2014.8\20141023-arc contains the 12 data that is
% very clean and controllable


% path_data_human = 'C:\Users\he\My Research\2014.8\20141028-arc\train\human\cut';
% path_data_dog ='C:\Users\he\My Research\2014.8\20141028-arc\train\ball\cut';
% path_data_human = 'C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\IIITDemo\Data\New\Controllable\Human\cut';
% path_data_dog ='C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\IIITDemo\Data\New\Controllable\Dog';



% path_data_human = 'C:\Users\he\My Research\2015.1\20150310-arc\cut\human';

% 
% path_data_human = 'C:\Users\he\My Research\2015.1\20150325-kh\cut\human';
% path_data_dog ='C:\Users\he\My Research\2015.1\20150325-kh\cut\ball';

% path_data_dog ='C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\IIITDemo\Data\New\Controllable\Dog';
% path_data_dog = 'C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\IIITDemo\Data\New\Dog\cut';

% path_data_human = 'C:\Users\he\My Research\2015.1\20150311-arc&prb\human';
% path_data_dog ='C:\Users\he\My Research\2015.1\20150311-arc&prb\ball';
% % path_data_dog ='C:\Users\he\My Research\2015.1\20150311-arc&prb&dog\ball';
% 



% path_data_human = 'C:\Users\he\My Research\2015.1\20150311-arc&kh\human';
% path_data_dog ='C:\Users\he\My Research\2015.1\20150311-arc&kh\ball';
% 
% path_data_human = 'C:\Users\he\My Research\2015.1\20150311-arc&prb&dog\human';
% path_data_dog ='C:\Users\he\My Research\2015.1\20150311-arc&prb&dog\ball';
% % 
% path_data_human = 'C:\Users\he\My Research\2015.1\20150311-arc&prb&kh&dog\human';
% path_data_dog ='C:\Users\he\My Research\2015.1\20150311-arc&prb&kh&dog\ball';
% 
% path_data_human='C:\Users\he\My Research\2015.1\TempSet\human';
% path_data_dog='C:\Users\he\My Research\2015.1\TempSet\ball';

% path_data_human='C:\Users\he\My Research\2015.1\20150311-arc&prb&kh\human';
% path_data_dog='C:\Users\he\My Research\2015.1\IIITDemo\ball';



% path_data_human = 'C:\Users\he\My Research\2015.1\IIITDemo\human';
% path_data_dog ='C:\Users\he\My Research\2015.1\IIITDemo\ball';



% path_data_human = 'C:\Users\he\My Research\2015.1\20150310-arc\cut\human\synthetic';
% path_data_dog ='C:\Users\he\My Research\2015.1\20150310-arc\cut\ball';
% 
% path_data_human = 'C:\Users\he\My Research\2015.1\20150311-prb\cut\human';
% path_data_dog ='C:\Users\he\My Research\2015.1\20150311-prb\cut\ball';
% 
% path_data_human = 'C:\Users\he\My Research\2015.1\20150403-kh\cut\human';
% path_data_dog ='C:\Users\he\My Research\2015.1\20150403-kh\cut\ball';
% 
% path_data_human = 'C:\Users\he\My Research\2015.1\20150404-ceiling\cut\human';
% path_data_dog ='C:\Users\he\My Research\2015.1\20150404-ceiling\cut\ball';



% path_data_human = 'C:\Users\he\My Research\2015.1\cross-environment\1\human';
% path_data_dog = 'C:\Users\he\My Research\2015.1\cross-environment\1\ball';
% % 
% path_data_human = 'C:\Users\he\My Research\2015.1\cross-environment\2\human';
% path_data_dog = 'C:\Users\he\My Research\2015.1\cross-environment\2\ball';
% % % % 
% path_data_human = 'C:\Users\he\My Research\2015.1\cross-environment\3\human';
% path_data_dog = 'C:\Users\he\My Research\2015.1\cross-environment\3\ball';
% % % % % 
% path_data_human = 'C:\Users\he\My Research\2015.1\cross-environment\1234\human';
% path_data_dog = 'C:\Users\he\My Research\2015.1\cross-environment\1234\ball';
% 
% path_data_human='C:\Users\he\My Research\2015.1\cross-kind\human - collectd by me, 200duo';
% path_data_dog='C:\Users\he\My Research\2015.1\cross-kind\ball&car';




% 
% path_data_human = 'C:\Users\he\My Research\2015.1\cross-environment\-1\human';
% path_data_dog = 'C:\Users\he\My Research\2015.1\cross-environment\-1\ball';
% % 
% path_data_human = 'C:\Users\he\My Research\2015.1\cross-environment\-2\human';
% path_data_dog = 'C:\Users\he\My Research\2015.1\cross-environment\-2\ball';
% % % 
% path_data_human = 'C:\Users\he\My Research\2015.1\cross-environment\-3\human';
% path_data_dog = 'C:\Users\he\My Research\2015.1\cross-environment\-3\ball';
% % % % 
% path_data_human = 'C:\Users\he\My Research\2015.1\cross-environment\-4\human';
% path_data_dog = 'C:\Users\he\My Research\2015.1\cross-environment\-4\ball';
% % 
% path_data_human = 'C:\Users\he\My Research\2015.1\cross-environment\1234\human';
% path_data_dog = 'C:\Users\he\My Research\2015.1\cross-environment\1234\ball';
% 


% path_data_human = 'C:\Users\he\My Research\2015.1\cross-environment\-2\human\frame_2.5s';
% path_data_dog = 'C:\Users\he\My Research\2015.1\cross-environment\-2\ball\frame_2.5s';

% path_data_human = 'C:\Users\he\My Research\2015.1\cross-environment\-2\human\frame_2.5s';
% path_data_dog = 'C:\Users\he\My Research\2015.1\cross-environment\-2\ball\frame_2.5s';


% path_data_human = 'C:\Users\he\My Research\2015.1\syntheticEvaluation\human\raw+synthetic';
% path_data_dog = 'C:\Users\he\My Research\2015.1\syntheticEvaluation\ball\raw+synthetic';
% 
% path_data_human = 'C:\Users\he\My Research\2015.1\syntheticEvaluation\human';
% path_data_dog = 'C:\Users\he\My Research\2015.1\syntheticEvaluation\ball';


% path_data_human = 'C:\Users\he\My Research\2015.1\remove-noise-data\good & bad\1\human';
% path_data_dog = 'C:\Users\he\My Research\2015.1\remove-noise-data\good & bad\1\ball';
%


% path_data_human = 'C:\Users\he\My Research\2015.1\cross-kind\human - height add into 200';
% path_data_dog = 'C:\Users\he\My Research\2015.1\cross-kind\trainset\ball&dog&car';
% 
% path_data_human = 'C:\Users\he\My Research\2015.1\moreBackHuman\human - 406';
% path_data_dog = 'C:\Users\he\My Research\2015.1\moreBackHuman\ball - 408';

% 
% path_data_human = 'C:\Users\he\My Research\2015.1\cross-environment\1234\human';
% path_data_dog = 'C:\Users\he\My Research\2015.1\cross-environment\1234\ball';

% path_data_human = 'C:\Users\he\My Research\2015.1\syntheticEvaluation\human';
% path_data_dog = 'C:\Users\he\My Research\2015.1\syntheticEvaluation\ball';

path_data_human = 'C:\Users\he\My Research\2015.1\syntheticEvaluation\1\human\synthetic2';
path_data_dog = 'C:\Users\he\My Research\2015.1\syntheticEvaluation\1\ball\synthetic2';

% path_data_human = 'C:\Users\he\My Research\2015.1\syntheticEvaluation\3\human';
% path_data_dog = 'C:\Users\he\My Research\2015.1\syntheticEvaluation\3\ball';

% path_data_human = 'C:\Users\he\My Research\2015.1\syntheticEvaluation\1\human\raw+synthetic1_old';
% path_data_dog = 'C:\Users\he\My Research\2015.1\syntheticEvaluation\1\ball\raw+synthetic1_old';

% path_data_human='C:\Users\he\My Research\2015.1\removeErroneousData\good & bad\3\human';
% path_data_dog='C:\Users\he\My Research\2015.1\removeErroneousData\good & bad\3\ball';
% 
% path_data_human='C:\Users\he\My Research\2015.1\removeErroneousData\good2\human';
% path_data_dog='C:\Users\he\My Research\2015.1\removeErroneousData\good2\ball';
%%%%%%%%%%%%%%%%%%%%%%%%%%% build f_set %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f_set=[];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% human
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
for i=1:length(Files) % take every file from the set 'Files'
    sprintf('%dth file is processing\n',i) % the i-th file is processing
    fileName=Files{i};
    f_file = File2Feature(fileName, 'Human', ifScaled, featureClass, feature_min, scalingFactors);
    f_set=[f_set;f_file];    
end

sprintf('the total num of files is: %d',length(Files))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% dog
cd(path_data_dog);
fileFullNames=dir;
Files={};  % first 2 file is '.' and '..'
i=1;
for j=1:length(fileFullNames)
    s=fileFullNames(j).name;
    k=strfind(s,'.data');
    if ~isempty(k) && k>=2 && k+4==length(s)
        Files{i}=s(1:k-1);
        i=i+1;
    end
end
for i=1:length(Files) % take every file from the set 'Files'
    sprintf('%dth file is processing\n',i) % the i-th file is processing
    fileName=Files{i};
    f_file=File2Feature(fileName, 'Dog', ifScaled, featureClass, feature_min, scalingFactors);
    f_set=[f_set;f_file];  
end
sprintf('the total num of files is: %d',length(Files))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% noise
% cd(path_data_noise);
% fileFullNames=dir;
% Files={};  % first 2 file is '.' and '..'
% i=1;
% for j=1:length(fileFullNames)
%     s=fileFullNames(j).name;
%     k=strfind(s,'.data');
%     if k>=2
%         Files{i}=s(1:k-1);
%         i=i+1;
%     end
% end
% for i=1:length(Files) % take every file from the set 'Files'
%     sprintf('%dth file is processing\n',i) % the i-th file is processing
%     fileName=Files{i}; 
%     f_file=File2Feature(fileName, 'Noise', ifScaled);
%     f_set=[f_set;f_file];     
% end
sprintf('the total num of files is: %d',length(Files)) 
sprintf('the total num of features is: %d',size(f_set,2)-1)

if (ifScaled==0)
    format shortg
    feature_max = max(cell2mat(f_set(:,1:size(f_set,2)-1)));
    feature_min = min(cell2mat(f_set(:,1:size(f_set,2)-1)));
    
    scalingFactors = zeros(1,length(feature_max));
    for j=1:length(feature_max)
        if feature_max(j)~=feature_min(j)
            scalingFactors(j) = 1/(feature_max(j)-feature_min(j));
        else
            scalingFactors(j) = 0;
        end
    end
    save('..\tmp');
end

%load('..\tmp');
%% Weka Related
% featureNames is f1 f2 f3 ...., give these name to the n columns of f_set
nColumn=size(f_set,2); 
featureNames=cell(1,nColumn);
for i=1:nColumn
    featureNames{i}= sprintf('f%d',i);
end

ifReg=0;
instances=matlab2weka(sprintf('radar%d',OutIndex),featureNames,f_set,nColumn,ifReg);

%% save the wekaOBJ to arff file
path_arff='C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\IIITDemo\Arff';
cd(path_arff);
if ifScaled == 0
    saveARFF(sprintf('radar%d.arff',OutIndex),instances);
else
    saveARFF(sprintf('radar%d_scaled.arff',OutIndex),instances);
end

%c=100000;
%gamma=0.1;


%% cross validation
% OutIndex=33;
totalNumInstances = size(f_set,1); % 52;
accuracy_max = 0;
c_max=0;
gamma_max=0;
if ifScaled == 1
    for c=[0.001 0.01 0.1 1 10 100 1000 100000 1000000] %[1 2 3 4 5 6 7 8 9 10 20 30 40 50 60 70 80 90 100]
        for gamma=[0.001 0.01 0.05 0.1 0.5 1 5 10] %[0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.1]
            [result, confusionmatrix] = Crossval_new(OutIndex,c, gamma);
            accuracy = (confusionmatrix(1,1) + confusionmatrix(2,2))/totalNumInstances;
            if (accuracy > accuracy_max)
                accuracy_max = accuracy;
                c_max = c;
                gamma_max =gamma;
            end
        end
    end
    [result, confusionmatrix] = Crossval_new(OutIndex,c_max, gamma_max); % renew the model txt file
    confusionmatrix
    accuracy_max
    c_max
    gamma_max
end


