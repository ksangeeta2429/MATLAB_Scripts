%function copyFilesToFolder(sourceFolder,destFolder)

SetEnvironment
SetPath

min_cut_length = 512; %samples
sourceFolder = strcat(g_str_pathbase_data,'/Human_vs_non_human_training_new_detector/M_30_N_128_window_res/austere_25_dog/')
destFolder = strcat(g_str_pathbase_data,'/Human_vs_non_human_training_new_detector/M_30_N_128_window_res/austere_25_dog/greater_than_equal_to_',num2str(min_cut_length),'/')
if ~exist(destFolder, 'dir')
    mkdir(destFolder);
end

cd(sourceFolder);
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
k = 0;

for i=1:length(Files) % take every file from the set 'Files'
    [I,Q,N]=Data2IQ(ReadBin([Files{i},'.data']));  %Extracting I and Q component from data
    if(N >= min_cut_length)
        copyfile(strcat(Files{i},'.data'),strcat(destFolder,strcat(Files{i},'.data')));
    end
end
