%% ToSN_parallel_2016.m
function ToSN_Directory_Structure_2016(arff_folderlist,rnd)
% 
% rnd = 2;
% arff_folderlist=Generate_Similarity_Set_Combinations(rnd);

SetEnvironment
SetPath

path_to_all_arffs = strcat(g_str_pathbase_radar,'/IIITDemo/Arff/Datasets_ToSN');

fid = fopen('env_vars.txt','wt');
fprintf(fid,'%s\n',g_str_pathbase_radar);
fprintf(fid,'%s\n',g_str_pathbase_model);
fprintf(fid,'%s',path_to_all_arffs);
fclose(fid);

for fld=1:length(arff_folderlist)
    path_temp = strcat(g_str_pathbase_radar,'/IIITDemo/Arff/BigEnvs/Round',num2str(rnd),'/',char(arff_folderlist{fld}), '/single_envs');
    
    if exist(path_temp, 'dir') ~= 7
        mkdir(path_temp); % Includes path_to_topk_arffs_scaled
        fprintf('INFO: created directory %s\n', path_temp);
    end
    
    s = char(arff_folderlist{fld});
    remain = s;
    
    while true
        [str, remain] = strtok(remain, '_');
        if isempty(str),  break;  end
        env = sprintf('%s', str);
        copyfile(strcat(path_to_all_arffs,'/radar',env,'_scaled.arff'),path_temp);
    end
end

for fld=1:length(arff_folderlist)
    path_to_training_arffs = strcat(g_str_pathbase_radar,'/IIITDemo/Arff/BigEnvs/Round',num2str(rnd),'/',char(arff_folderlist{fld}), '/single_envs');
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
    
    cd(path_to_all_arffs);
    fileFullNames=dir('*.arff');
    
    i=1;
    allFiles={};
    for j=1:length(fileFullNames)
        s=fileFullNames(j).name;
        k=strfind(s,'.arff');
        if ~isempty(k) && k>=2 && k+4==length(s)
            allFiles{i}=s(1:k-1);
            i=i+1;
        end
    end
    
    testFiles = setdiff(allFiles,trainFiles);
    
    path_to_test_arffs = strcat(g_str_pathbase_radar,'/IIITDemo/Arff/BigEnvs/Round',num2str(rnd),'/',char(arff_folderlist{fld}), '/test');
    
    if exist(path_to_test_arffs, 'dir') ~= 7
        mkdir(path_to_test_arffs); % Includes path_to_topk_arffs_scaled
        fprintf('INFO: created directory %s\n', path_to_test_arffs);
    end
    
    for f=1:length(testFiles)
        copyfile(strcat(path_to_all_arffs,'/',testFiles{f},'.arff'),path_to_test_arffs);
    end
    
    path_to_combined_arffs = strcat(g_str_pathbase_radar,'/IIITDemo/Arff/BigEnvs/Round',num2str(rnd),'/',char(arff_folderlist{fld}), '/combined');
    
    if exist(path_to_combined_arffs, 'dir') ~= 7
        mkdir(path_to_combined_arffs); % Includes path_to_topk_arffs_scaled
        fprintf('INFO: created directory %s\n', path_to_combined_arffs);
    end
    
    path_to_temp_all=strcat(g_str_pathbase_radar,'/IIITDemo/Arff/temp-all');
    
    if exist(path_to_temp_all, 'dir') ~= 7
        mkdir(path_to_temp_all); % Includes path_to_topk_arffs_scaled
        fprintf('INFO: created directory %s\n', path_to_temp_all);
    end
    
    cd(path_to_temp_all);
    delete('*.arff');
    
    
    path_to_temp_comb=strcat(g_str_pathbase_radar,'/IIITDemo/Arff/combined');
    
    if exist(path_to_temp_comb, 'dir') ~= 7
        mkdir(path_to_temp_comb); % Includes path_to_topk_arffs_scaled
        fprintf('INFO: created directory %s\n', path_to_temp_comb);
    end
    
    cd(path_to_temp_comb);
    delete('*.arff');
    
    for f=1:length(trainFiles)
        copyfile(strcat(path_to_all_arffs,'/',trainFiles{f},'.arff'),path_to_temp_all);
    end
    
    Combine_arff_doit_v2;
    movefile(strcat(g_str_pathbase_radar,'/IIITDemo/Arff/combined/*.arff'),path_to_combined_arffs);
end

fprintf('\n\nAll done!\n', path_to_combined_arffs);

% parfor fld=1:length(arff_folderlist)
%     fldr = char(arff_folderlist{fld});
%     RunResultsScript_BigEnvs_ToSN(rnd,fldr,10);
%     RunResultsScript_BigEnvs_ToSN(rnd,fldr,20);
%     
%     RunResultsScript_BigEnvs_ToSN(rnd,fldr,30);
%     RunResultsScript_BigEnvs_ToSN(rnd,fldr,40);
%     RunResultsScript_BigEnvs_ToSN(rnd,fldr,50);
%     RunResultsScript_BigEnvs_ToSN(rnd,fldr,60);
% end
% 
% for cur_rnd={'10' '20' '30' '40' '50' '60'}
%     fldr = char(arff_folderlist{1});
%     evalstr = strcat('crossval_str_',char(cur_rnd),'=crossval_',fldr,'_r1_top',char(cur_rnd),';');
%     eval([evalstr]);
%     evalstr2 = strcat('crossenv_str_',char(cur_rnd),'=crossenv_',fldr,'_r1_top',char(cur_rnd),';');
%     eval([evalstr2]);
% end
% 
% 
% for fld=2:length(arff_folderlist)
%     for cur_rnd={'10' '20' '30' '40' '50' '60'}
%         fldr = char(arff_folderlist{fld});
%         evalstr = strcat('crossval_str_',char(cur_rnd),'=crossval_',fldr,'_r1_top',char(cur_rnd),';');
%         eval([evalstr]);
%         evalstr2 = strcat('crossenv_str_',char(cur_rnd),'=crossenv_',fldr,'_r1_top',char(cur_rnd),';');
%         eval([evalstr2]);
%     end
% end
% 
% dlmwrite(strcat(g_str_pathbase_radar,'/IIITDemo/Arff/BigEnvs/Round',num2str(round),'/crossenv_',list_features{f},'_humans.csv'),results_per_sheet);
% 
% for cur_rnd={'10' '20' '30' '40' '50' '60'}
%     eval(['crossval=crossval_str_' char(cur_rnd)]);
%     eval(['crossenv=crossenv_str_' char(cur_rnd)]);
%     eval(['dlmwrite(strcat(g_str_pathbase_radar,''/IIITDemo/Arff/BigEnvs/Round'',num2str(round),''/crossval_str_'',char(cur_rnd),''.csv''),crossval);']);
%     eval(['dlmwrite(strcat(g_str_pathbase_radar,''/IIITDemo/Arff/BigEnvs/Round'',num2str(round),''/crossenv_str_'',char(cur_rnd),''.csv''),crossenv);']);
% end