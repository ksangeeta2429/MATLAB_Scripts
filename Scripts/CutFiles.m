% CutFile.m will cut one file to n files, using displacement detection algorithm,
% call CutFile on all the files in the given folder,put the generated files in the subfolder .\cut\



SetEnvironment
SetPath

%% INPUT:

% path_data_human = 'C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\IIITDemo\Data\New\Controllable\Human';
% path_data_dog = 'C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\IIITDemo\Data\New\Controllable\Dog';

% path_data_human = 'C:\Users\he\My Research\2014.8\20141028-arc\train\human';
% path_data_dog = 'C:\Users\he\My Research\2014.8\20141028-arc\train\ball'


% path_data_human = 'C:\Users\he\My Research\2014.8\20141028-arc\train\human';
% path_data_dog = 'C:\Users\he\My Research\2015.1\20150224-arc\ball'

% path_data_human = 'C:\Users\he\My Research\2015.1\20150311-prb';
% path_data_human = 'C:\Users\he\My Research\2015.1\20150310-arc';
% path_data_human = 'C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\IIITDemo\Data\New\Dog';
% path_data_human = 'C:\Users\he\My Research\2015.1\20150325-kh';
% path_data_human = 'C:\Users\he\My Research\2015.1\20150403-kh';
% path_data_human = 'C:\Users\he\Documents\Dropbox\ADAPT Data Collection\Radar\Hardware Tuning\14-10-17-nathan-radar';
% path_data_human = 'C:\Users\he\My Research\2015.1\20150203-arc';
% path_data_human = 'C:\Users\he\My Research\2015.1\20150713-parkinglot';
% path_data_human='C:\Users\he\My Research\2015.1\20150730-orthogonal';

% path_data_human = strrep('C:\Users\royd\Desktop\Temp\osu_farm_nearshed_may24_2016','\','/');

% path_data_human = 'C:\Users\royd\Documents\WIP\Parking garage radial ortho (Sandeep)\radial';
% path_data_human = 'C:\Users\royd\Documents\WIP\Darree_Fields';
%path_data_human = 'C:\Users\roy.174\Documents\HornNet Data (radar,network)\Darree_humans_and_groups_Oct_2016\Darree_Fields_grass_17_Oct_2016';
path_data_human = strcat(g_str_pathbase_data,'/Bike data/March 25 2017');
%% %%%%%%%%%%%%%%%%%%%%% human
cd(path_data_human);

cut_folder = './cut';
if exist(cut_folder, 'dir') ~= 7
    mkdir(cut_folder);
    fprintf('INFO: created directory %s\n', cut_folder);
end

fileFullNames=dir;
Files={};  % first 2 file is '.' and '..'
i=1;
for j=1:length(fileFullNames)
    s=fileFullNames(j).name;
    %% Also change line# 17-18 in CutFile.m
    k=strfind(s,'.bbs');
    if ~isempty(k) && k>=2 && k+3==length(s)
        Files{i}=s(1:k-1);
        i=i+1;
    end
end

sampleRate = 256;

allstarts = [];
allstops=[];
for i=1:length(Files) % take every file from the set 'Files'
    sprintf('%dth file is processing\n',i) % the i-th file is processing
    fileName=Files{i} 
    [ncut, start, stop] = CutFile(fileName);
    allstarts=[allstarts;start'/sampleRate];
    allstops=[allstops;stop'/sampleRate];
    disp(allstarts);
    disp(allstops);
%     pause;
end



% path_data=[path_data_human,'\cut'];
% Visualize_all;


% %% %%%%%%%%%%%%%%%%%%%%% dog
% cd(path_data_dog);
% fileFullNames=dir;
% Files={};  % first 2 file is '.' and '..'
% i=1;
% for j=1:length(fileFullNames)
%     s=fileFullNames(j).name;
%     k=strfind(s,'.data');
%     if ~isempty(k) && k>=2 && k+4==length(s)
%         Files{i}=s(1:k-1);
%         i=i+1;
%     end
% end
% 
% for i=1:length(Files) % take every file from the set 'Files'
%     sprintf('%dth file is processing\n',i) % the i-th file is processing
%     fileName=Files{i}; 
%     CutFile(fileName);
% end