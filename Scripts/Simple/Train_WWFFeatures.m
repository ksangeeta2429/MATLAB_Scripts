SetEnvironment
SetPath

env_list = {'1', '4', '5', '6', '7', '8', '9', '11'}; % Input cell array
testFiles = {'1', '4', '5', '6', '7', '8', '9', '11'}; % Input cell array

% arff_folder = {'1456789'};
arff_folder = strjoin(env_list,'_');
rnd=100; % Includes 3 cow sets

path_to_all_arffs = strcat(g_str_pathbase_radar,'/IIITDemo/Arff/Datasets_87features'); % Only path you need to set. Make sure it has the required files.

path_temp = strcat(g_str_pathbase_radar,'/IIITDemo/Arff/BigEnvs/Round',num2str(rnd),'/',arff_folder, '/single_envs');

if exist(path_temp, 'dir') ~= 7
    mkdir(path_temp);
    fprintf('INFO: created directory %s\n', path_temp);
end

for e=1:length(env_list)
    copyfile(strcat(path_to_all_arffs,'/radar',env_list{e},'_scaled.arff'),path_temp);
end

%     env1 = arff_folder{fld}(1);
%     env2 = arff_folder{fld}(2);
%     env3 = arff_folder{fld}(3);
%     env4 = arff_folder{fld}(4);
%     env5 = arff_folder{fld}(5);
%     env6 = arff_folder{fld}(6);
%     env7 = arff_folder{fld}(7);
%
%     copyfile(strcat(path_to_all_arffs,'/radar',env1,'_scaled.arff'),path_temp);
%     copyfile(strcat(path_to_all_arffs,'/radar',env2,'_scaled.arff'),path_temp);
%     copyfile(strcat(path_to_all_arffs,'/radar',env3,'_scaled.arff'),path_temp);
%     copyfile(strcat(path_to_all_arffs,'/radar',env4,'_scaled.arff'),path_temp);
%     copyfile(strcat(path_to_all_arffs,'/radar',env5,'_scaled.arff'),path_temp);
%     copyfile(strcat(path_to_all_arffs,'/radar',env6,'_scaled.arff'),path_temp);
%     copyfile(strcat(path_to_all_arffs,'/radar',env7,'_scaled.arff'),path_temp);

path_to_combined_arffs = strcat(g_str_pathbase_radar,'/IIITDemo/Arff/BigEnvs/Round',num2str(rnd),'/',arff_folder, '/combined');

if exist(path_to_combined_arffs, 'dir') ~= 7
    mkdir(path_to_combined_arffs); % Includes path_to_topk_arffs_scaled
    fprintf('INFO: created directory %s\n', path_to_combined_arffs);
end

path_to_temp_all=(strcat(g_str_pathbase_radar,'/IIITDemo/Arff/temp-all'));
cd(path_to_temp_all);
delete('*.arff');

cd(strcat(g_str_pathbase_radar,'/IIITDemo/Arff/combined'));
delete('*.arff');

path_to_training_arffs = strcat(g_str_pathbase_radar,'/IIITDemo/Arff/BigEnvs/Round',num2str(rnd),'/',arff_folder, '/single_envs');
cd(path_to_training_arffs);
fileFullNames=dir('*.arff');

i=1;
trainFiles={};
for j=1:length(fileFullNames)
    s=fileFullNames(j).name;
    k=strfind(s,'.arff');
    if ~isempty(k) && k>=2 && k+4==length(s)
        trainFiles{i}=s(1:k-1);
        i=i+1;
    end
end

for f=1:length(trainFiles)
    copyfile(strcat(path_to_all_arffs,'/',trainFiles{f},'.arff'),path_to_temp_all);
end

Combine_arff_doit_v2;
movefile(strcat(g_str_pathbase_radar,'/IIITDemo/Arff/combined/*.arff'),path_to_combined_arffs);

path_to_test_arffs = strcat(g_str_pathbase_radar,'/IIITDemo/Arff/BigEnvs/Round',num2str(rnd),'/',arff_folder, '/test');

if exist(path_to_test_arffs, 'dir') ~= 7
    mkdir(path_to_test_arffs); % Includes path_to_topk_arffs_scaled
    fprintf('INFO: created directory %s\n', path_to_test_arffs);
end

for f=1:length(testFiles)
    copyfile(strcat(path_to_all_arffs,'/radar',testFiles{f},'_scaled.arff'),path_to_test_arffs);
end

% for cur_rnd={'10' '20' '30' '40' '50' '60'}
for cur_rnd={'10' '15'}
    fprintf('###### EXECUTING ROUND %s #####\n', char(cur_rnd));
    fldr = char(arff_folder);
    evalstr=strcat('[crossval_',fldr,'_r1_top',char(cur_rnd),',','crossenv_',fldr,'_r1_top',char(cur_rnd),']=RunResultsScript_BigEnvs_ToSN(rnd,fldr,str2num(char(cur_rnd)));');
    eval([evalstr]);
end


for cur_rnd={'10'}
    fldr = char(arff_folder);
    eval(['crossval_str_' char(cur_rnd) '=crossval_' fldr '_r1_top' char(cur_rnd) ';']);
    eval(['crossenv_str_' char(cur_rnd) '=crossenv_' fldr '_r1_top' char(cur_rnd) ';']);
end


for cur_rnd={'15'}
        fldr = char(arff_folder);
        eval(['crossval_str_' char(cur_rnd) '=[crossval_str_' char(cur_rnd) '; crossval_' fldr '_r1_top' char(cur_rnd) '];']);
        eval(['crossenv_str_' char(cur_rnd) '=[crossenv_str_' char(cur_rnd) '; crossenv_' fldr '_r1_top' char(cur_rnd) '];']);
end