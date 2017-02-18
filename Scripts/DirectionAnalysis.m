% DirectionAnalysis.m
% compute the statistics of different radials for both human and ball
% cut the data files first.

SetEnvironment
SetPath

%% INPUT:
path_data = 'C:\Users\he\My Research\2015.1\20150311-prb\cut\ball\DirectionAnalysis\1';

%% GET FILES
cd(path_data);
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

%% COMPUTE
powerMean = zeros(1,length(Files));
amplitudeMean = zeros(1,length(Files));
powerMedian = zeros(1,length(Files));
amplitudeMedian = zeros(1,length(Files));
powerStd = zeros(1,length(Files));
amplitudeStd = zeros(1,length(Files));
for j=1:length(Files) % take every file from the set 'Files'
    sprintf('%dth file is processing\n',j) % the i-th file is processing
    fileName=Files{j}; 
    [I,Q,N]=Data2IQ(ReadBin([fileName,'.data']));
    data = (I-mean(I))+1j*(Q-mean(Q));
    powerMax(j) = max(abs(data).^2);
    amplitudeMax(j) = max(abs(data));
    powerMean(j) = mean(abs(data).^2);
    amplitudeMean(j) = mean(abs(data));
    powerMedian(j) = median(abs(data).^2);
    amplitudeMedian(j) = median(abs(data)); 
    powerStd(j) = std(abs(data).^2);
    amplitudeStd(j) = std(abs(data));
end

format short g
[mean(powerMax),mean(amplitudeMax),mean(powerMean),mean(amplitudeMean),mean(powerMedian),mean(amplitudeMedian),mean(powerStd),mean(amplitudeStd)]
amplitudeMean


