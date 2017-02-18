% FrameFiles.m


SetEnvironment
SetPath
% 
% path_data_human = 'C:\Users\he\My Research\2014.8\20141028-arc\train\human\cut';
% path_data_dog = 'C:\Users\he\My Research\2014.8\20141028-arc\train\ball\cut';
% 
% path_data_human = 'C:\Users\he\My Research\2015.1\20150311-arc&prb\human';
% path_data_dog = 'C:\Users\he\My Research\2015.1\20150311-arc&prb\ball';
% 
% path_data_human = 'C:\Users\he\My Research\2015.1\20150311-arc&prb&dog\human';
% path_data_dog = 'C:\Users\he\My Research\2015.1\20150311-arc&prb&dog\ball';
% 
% path_data_human = 'C:\Users\he\My Research\2015.1\20150310-arc\cut\human';
% path_data_dog = 'C:\Users\he\My Research\2015.1\20150310-arc\cut\ball';
% 
% path_data_human = 'C:\Users\he\My Research\2015.1\cross-environment\-2\human';
% path_data_dog = 'C:\Users\he\My Research\2015.1\cross-environment\-2\ball';

path_data_human = strcat(g_str_pathbase_data,'training\crossenvironment\2\human');
path_data_dog   = strcat(g_str_pathbase_data,'\training\crossenvironment\2\ball'); %Jin's laptop: 'C:\Users\he\My Research\2015.1\cross-environment\2\ball';



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

for i=1:length(Files) % take every file from the set 'Files'
    sprintf('%dth file is processing\n',i) % the i-th file is processing
    fileName=Files{i}; 
    FrameFile(fileName);
end


%% %%%%%%%%%%%%%%%%%%%%% dog
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
    FrameFile(fileName);
end