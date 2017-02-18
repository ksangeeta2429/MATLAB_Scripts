% delete cutted files that is not useful
clc;

path_data_human = 'C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\IIITDemo\Data\New\Human\cut';
path_data_dog = 'C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\IIITDemo\Data\New\Dog\cut';
path_data_noise = 'C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\IIITDemo\Data\New\Noise';


'Human'
%% %%%%%%%%%%%%%%%%%%%%% human
cd(path_data_human);
fileFullNames=dir;
Files={};  % first 2 file is '.' and '..'
i=1;
for j=1:length(fileFullNames)
    s=fileFullNames(j).name;
    k=strfind(s,'.data');
    if k>=2
        Files{i}=s(1:k-1);
        i=i+1;
    end
end

for i=1:length(Files) % take every file from the set 'Files'
    fileName=Files{i}; 
    
    f_file=File2Feature(fileName, '', 0, 0, 0, 0);
    if (f_file{11}<5) % bad
        fileName
        f_file{11}
    end
end

'Dog'
%% %%%%%%%%%%%%%%%%%%%%% dog
cd(path_data_dog);
fileFullNames=dir;
Files={};  % first 2 file is '.' and '..'
i=1;
for j=1:length(fileFullNames)
    s=fileFullNames(j).name;
    k=strfind(s,'.data');
    if k>=2
        Files{i}=s(1:k-1);
        i=i+1;
    end
end

for i=1:length(Files) % take every file from the set 'Files'
    fileName=Files{i}; 
        f_file=File2Feature(fileName, '', 0, 0, 0, 0);
    fileName
    f_file{11}
    if (f_file{11}<5) % bad
%         fileName
%         f_file{11}
    end
end