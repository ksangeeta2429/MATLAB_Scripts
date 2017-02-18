SetEnvironment
SetPath
arff_folder = {'3', '5', '7', '8'};

rnd=1;

path_to_all_arffs = strcat(g_str_pathbase_radar,'/IIITDemo/Arff/Datasets_Sensys16');
for fld=1:length(arff_folder)
    path_to_training_arffs = strcat(g_str_pathbase_radar,'/IIITDemo/Arff/BigEnvs/Round',num2str(rnd),'/',arff_folder{fld}, '/single_envs');
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
    
    path_to_test_arffs = strcat(g_str_pathbase_radar,'/IIITDemo/Arff/BigEnvs/Round',num2str(rnd),'/',arff_folder{fld}, '/test');
    
    if exist(path_to_test_arffs, 'dir') ~= 7
        mkdir(path_to_test_arffs); % Includes path_to_topk_arffs_scaled
        fprintf('INFO: created directory %s\n', path_to_test_arffs);
    end
    
    for f=1:length(testFiles)
        copyfile(strcat(path_to_all_arffs,'/',testFiles{f},'.arff'),path_to_test_arffs);
    end
    
    path_to_combined_arffs = strcat(g_str_pathbase_radar,'/IIITDemo/Arff/BigEnvs/Round',num2str(rnd),'/',arff_folder{fld}, '/combined');
    
    if exist(path_to_combined_arffs, 'dir') ~= 7
        mkdir(path_to_combined_arffs); % Includes path_to_topk_arffs_scaled
        fprintf('INFO: created directory %s\n', path_to_combined_arffs);
    end
    
    path_to_temp_all=(strcat(g_str_pathbase_radar,'/IIITDemo/Arff/temp-all'));
    cd(path_to_temp_all);
    delete('*.arff');
    
    cd(strcat(g_str_pathbase_radar,'/IIITDemo/Arff/combined'));
    delete('*.arff');
    
    for f=1:length(trainFiles)
        copyfile(strcat(path_to_all_arffs,'/',trainFiles{f},'.arff'),path_to_temp_all);
    end
    
    Combine_arff_doit_v2;
    movefile(strcat(g_str_pathbase_radar,'/IIITDemo/Arff/combined/*.arff'),path_to_combined_arffs);
end

[crossval_3_r1_top10,crossenv_3_r1_top10]=RunResultsScript_BigEnvs_SenSys(1, '3', 10);
[crossval_3_r1_top20,crossenv_3_r1_top20]=RunResultsScript_BigEnvs_SenSys(1, '3', 20);
[crossval_3_r1_top30,crossenv_3_r1_top30]=RunResultsScript_BigEnvs_SenSys(1, '3', 30);
[crossval_3_r1_top40,crossenv_3_r1_top40]=RunResultsScript_BigEnvs_SenSys(1, '3', 40);
[crossval_3_r1_top50,crossenv_3_r1_top50]=RunResultsScript_BigEnvs_SenSys(1, '3', 50);
[crossval_3_r1_top60,crossenv_3_r1_top60]=RunResultsScript_BigEnvs_SenSys(1, '3', 60);

[crossval_5_r1_top10,crossenv_5_r1_top10]=RunResultsScript_BigEnvs_SenSys(1, '5', 10);
[crossval_5_r1_top20,crossenv_5_r1_top20]=RunResultsScript_BigEnvs_SenSys(1, '5', 20);
[crossval_5_r1_top30,crossenv_5_r1_top30]=RunResultsScript_BigEnvs_SenSys(1, '5', 30);
[crossval_5_r1_top40,crossenv_5_r1_top40]=RunResultsScript_BigEnvs_SenSys(1, '5', 40);
[crossval_5_r1_top50,crossenv_5_r1_top50]=RunResultsScript_BigEnvs_SenSys(1, '5', 50);
[crossval_5_r1_top60,crossenv_5_r1_top60]=RunResultsScript_BigEnvs_SenSys(1, '5', 60);

[crossval_7_r1_top10,crossenv_7_r1_top10]=RunResultsScript_BigEnvs_SenSys(1, '7', 10);
[crossval_7_r1_top20,crossenv_7_r1_top20]=RunResultsScript_BigEnvs_SenSys(1, '7', 20);
[crossval_7_r1_top30,crossenv_7_r1_top30]=RunResultsScript_BigEnvs_SenSys(1, '7', 30);
[crossval_7_r1_top40,crossenv_7_r1_top40]=RunResultsScript_BigEnvs_SenSys(1, '7', 40);
[crossval_7_r1_top50,crossenv_7_r1_top50]=RunResultsScript_BigEnvs_SenSys(1, '7', 50);
[crossval_7_r1_top60,crossenv_7_r1_top60]=RunResultsScript_BigEnvs_SenSys(1, '7', 60);

[crossval_8_r1_top10,crossenv_8_r1_top10]=RunResultsScript_BigEnvs_SenSys(1, '8', 10);
[crossval_8_r1_top20,crossenv_8_r1_top20]=RunResultsScript_BigEnvs_SenSys(1, '8', 20);
[crossval_8_r1_top30,crossenv_8_r1_top30]=RunResultsScript_BigEnvs_SenSys(1, '8', 30);
[crossval_8_r1_top40,crossenv_8_r1_top40]=RunResultsScript_BigEnvs_SenSys(1, '8', 40);
[crossval_8_r1_top50,crossenv_8_r1_top50]=RunResultsScript_BigEnvs_SenSys(1, '8', 50);
[crossval_8_r1_top60,crossenv_8_r1_top60]=RunResultsScript_BigEnvs_SenSys(1, '8', 60);


