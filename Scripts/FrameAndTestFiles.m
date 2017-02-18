% FrameAndTestFile.m will frame one file to n frames and apply the model
% trained from frames and high-level hueristics on them.
% call FrameAndTestFile on all the files in the given folder, every file
% will return a classification result, so the statistics like
% classification accuracy can be computed from the 2 folder (human and dog)


% feature_min=feature_min0;
% scalingFactors=scalingFactors0;
% SV_matlab;
% param;
% gamma;
% rho;

SetEnvironment
SetPath

%% INPUT:
%CHOOSE DATA
% path_data_human = strcat(str_pathbase_data,'raw\20141028-arc\train\human\cut');
% path_data_dog   = strcat(str_pathbase_data,'raw\20141028-arc\train\ball\cut' );
% 
% path_data_human = strcat(str_pathbase_data,'raw\20150311-arc&prb\human');
% path_data_dog   = strcat(str_pathbase_data,'raw\20150311-arc&prb\ball' );
% 
% path_data_human = strcat(str_pathbase_data,'raw\20150311-prb\cut\human');
% path_data_dog   = strcat(str_pathbase_data,'raw\20150311-prb\cut\ball' );
% 
% path_data_human = strcat(str_pathbase_data,'raw\20150310-arc\cut\human');
% path_data_dog   = strcat(str_pathbase_data,'raw\20150310-arc\cut\ball' );

path_data_human = strcat(str_pathbase_data,'training\cross-environment\2\human');
path_data_dog   = strcat(str_pathbase_data,'training\cross-environment\2\ball' );


%% %%%%%%%%%%%%%%%%%%%%% human - class0
class=0;

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

nCorrect0=0;
nWrong0=0;
for i=1:length(Files) % take every file from the set 'Files'
    sprintf('%dth file is processing\n',i) % the i-th file is processing
    fileName=Files{i}; 
    classificationResult=FrameAndTestFile(fileName,feature_min,scalingFactors, SV_matlab, param,gamma,rho);
    if classificationResult==class 
        nCorrect0=nCorrect0+1;
    else nWrong0=nWrong0+1;
    end
end


%% %%%%%%%%%%%%%%%%%%%%% dog - class1
class=1;

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

nCorrect1=0;
nWrong1=0;
for i=1:length(Files) % take every file from the set 'Files'
    sprintf('%dth file is processing\n',i) % the i-th file is processing
    fileName=Files{i}; 
    classificationResult=FrameAndTestFile(fileName,feature_min,scalingFactors, SV_matlab, param,gamma,rho);
    if classificationResult==class 
        nCorrect1=nCorrect1+1;
    else nWrong1=nWrong1+1;
    end
end

%%%%%%%%%%%%%%%%%%%%%%% Conclude
nCorrect=nCorrect0+nCorrect1
nWrong = nWrong0+nWrong1
accuracy = nCorrect/(nCorrect+nWrong)