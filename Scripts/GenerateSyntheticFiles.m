% given some data points, everyone is a sample
% generate synthetic data, in feature space - NO!
% generate synthetic data, in parameter space

SetEnvironment
SetPath

%% INPUT:
path_data_human = 'C:\Users\he\My Research\2015.1\test\1\ball';


%% %%%%%%%%%%%%%%%%%%%%% human
cd(path_data_human);
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

scalingFactors = [0 0.025 0.05 0.075 0.1 0.125 0.15];


for j=1:nFactors
%     scalingFactor = start*step^(j-1);
%     scalingFactor = start+step*(j-1);
    scalingFactor = scalingFactors(j);
    for i=1:length(Files) % take every file from the set 'Files'
        sprintf('%dth file is processing\n',i) % the i-th file is processing
        fileName=Files{i} 
%          GenerateSyntheticFile_amplitude(fileName,scalingFactor);
%          GenerateSyntheticFile_phase_speed(fileName,scalingFactor);
         GenerateSyntheticFile_phase_orthogonal(fileName,8,8*scalingFactor);
    %     pause;
    end
end

    