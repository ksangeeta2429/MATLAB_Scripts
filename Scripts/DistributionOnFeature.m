%% check which feature has better distribution separation
% given a folder of data,
% call File2Feature
% tell you how every feature's distribution on two classes are separated in
% this folder

% should run Execute.m first if you change the features. Otherwise the calingFactors features_min are
% wrong.

SetEnvironment
SetPath

%% INPUT:
path_data_human = 'C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\IIITDemo\Data\New\Controllable\Human\cut';
path_data_dog ='C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\IIITDemo\Data\New\Controllable\Dog';

%% COMPUTE:
median0 = zeros(1,18);
std0 = zeros(1,18);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% human
cd(path_data_human);
fileFullNames=dir;

Files={};  % first 2 file is '.' and '..'
i=1;
f_set=[];
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
    f_file = File2Feature(fileName, 'Human', 1, 0, feature_min, scalingFactors);
    f_set=[f_set;f_file];    
end
sprintf('the total num of files is: %d',length(Files))

f_set = cell2mat(f_set(:,1:size(f_file,2)-1));
mean0 = mean(f_set);
std0 = std(f_set);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% dog
cd(path_data_dog);
fileFullNames=dir;
Files={};  % first 2 file is '.' and '..'
i=1;
f_set=[];
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
    f_file=File2Feature(fileName, 'Dog', 1, 0, feature_min, scalingFactors);
    f_set=[f_set;f_file];  
end
sprintf('the total num of files is: %d',length(Files))


f_set = cell2mat(f_set(:,1:size(f_file,2)-1));
mean1 = mean(f_set);
std1 = std(f_set);


% Fisher discriminant method 
distributionDistanceFactor = (mean0-mean1).^2./(std0.^2+std1.^2)

% my method
%distributionDistanceFactor = (std0+std1)./abs(median0-median1)