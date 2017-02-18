% ComputeDataLengthFiles.m
% find the time in minutes of all *.data files in a directory
% assumes all files are same sampling rate.
% Author: Jin He
% Updated: Michael McGrath, 2015-10-16, add comments, make generic.
% run this on Samraksh walk data


%% Set path for MATLAB to find other scripts
SetEnvironment

%% Set local variables
samples_per_second = 256;
seconds_per_minute = 60;
str_data_file_extension = '.data';


%% INPUT DIRECTORY:
path_data_human = 'C:\Users\he\Documents\Dropbox\ADAPT Data Collection\Radar\Debugging\RadarWalkData-CornFieldSnow-40KHz';

%% %%%%%%%%%%%%%%%%%%%%% human
cd(path_data_human);
fileFullNames=dir;
Files={};  % first 2 file is '.' and '..'
i=1;
for j=1:length(fileFullNames)
    s=fileFullNames(j).name;
    k=strfind(s, str_data_file_extension);
    if ~isempty(k) && k>=2 && k+4==length(s)
        Files{i}=s(1:k-1);
        i=i+1;
    end
end


for i=1:length(Files) % take every file from the set 'Files'
    sprintf('%dth file is processing\n',i) % the i-th file is processing
    fileName=Files{i} 
    data = ReadBin( [fileName,str_data_file_extension] );
    nMin=length(data) / samples_per_second / seconds_per_minute;
    sumMin = sumMin+nMin;
%     pause;
end
sumMin