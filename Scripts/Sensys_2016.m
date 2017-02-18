%% Sensys_2016.m

SetEnvironment
SetPath
arff_folder = {'1234',	'1235',	'12310',	'1245',	'12410',	'12510',	'1345',	'13410',	'13510',	'14510',	'2345',	'23410',	'23510',	'24510',	'34510'};

rnd=-4;

path_to_all_arffs = strcat(g_str_pathbase_radar,'/IIITDemo/Arff/Data_all_1234510');

for fld=1:length(arff_folder)
    path_temp = strcat(g_str_pathbase_radar,'/IIITDemo/Arff/BigEnvs/Round',num2str(rnd),'/',arff_folder{fld}, '/single_envs');
    
    if exist(path_temp, 'dir') ~= 7
    mkdir(path_temp); % Includes path_to_topk_arffs_scaled
    fprintf('INFO: created directory %s\n', path_temp);
    end
    
    if length(arff_folder)==nchoosek(6,4)
        env1 = arff_folder{fld}(1);
        env2 = arff_folder{fld}(2);
        env3 = arff_folder{fld}(3);
        env4 = arff_folder{fld}(4:end);
        copyfile(strcat(path_to_all_arffs,'/radar',env1,'_scaled.arff'),path_temp);
        copyfile(strcat(path_to_all_arffs,'/radar',env2,'_scaled.arff'),path_temp);
        copyfile(strcat(path_to_all_arffs,'/radar',env3,'_scaled.arff'),path_temp);
        copyfile(strcat(path_to_all_arffs,'/radar',env4,'_scaled.arff'),path_temp);
    end
end

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


for fld=1:length(arff_folder)
    for cur_rnd={'10' '20' '30' '40' '50' '60'}
        fldr = char(arff_folder{fld});
        eval(['[crossval_' fldr '_r1_top' char(cur_rnd) ',crossenv_' fldr '_r1_top' char(cur_rnd) ']=RunResultsScript_BigEnvs_SenSys(rnd,' fldr ',' char(cur_rnd) ');']);
    end
end


for cur_rnd={'10' '20' '30' '40' '50' '60'}
    fldr = char(arff_folder{1});
    eval(['crossval_str_' char(cur_rnd) '=crossval_' fldr '_r1_top' char(cur_rnd) ';']);
    eval(['crossenv_str_' char(cur_rnd) '=crossenv_' fldr '_r1_top' char(cur_rnd) ';']);
end


for fld=2:length(arff_folder)
    for cur_rnd={'10' '20' '30' '40' '50' '60'}
        fldr = char(arff_folder{fld});
        eval(['crossval_str_' char(cur_rnd) '=[crossval_str_' char(cur_rnd) '; crossval_' fldr '_r1_top' char(cur_rnd) '];']);
        eval(['crossenv_str_' char(cur_rnd) '=[crossenv_str_' char(cur_rnd) '; crossenv_' fldr '_r1_top' char(cur_rnd) '];']);
    end
end


% crossval_str_10 = strcat('crossval_',arff_folder{1},'_r1_top10');
% crossenv_str_10 = strcat('crossenv_',arff_folder{1},'_r1_top10');
% 
% crossval_str_20 = strcat('crossval_',arff_folder{1},'_r1_top10');
% crossenv_str_20 = strcat('crossenv_',arff_folder{1},'_r1_top10');
% 
% crossval_str_30 = strcat('crossval_',arff_folder{1},'_r1_top10');
% crossenv_str_30 = strcat('crossenv_',arff_folder{1},'_r1_top10');
% 
% crossval_str_40 = strcat('crossval_',arff_folder{1},'_r1_top10');
% crossenv_str_40 = strcat('crossenv_',arff_folder{1},'_r1_top10');
% 
% crossval_str_50 = strcat('crossval_',arff_folder{1},'_r1_top10');
% crossenv_str_50 = strcat('crossenv_',arff_folder{1},'_r1_top10');
% 
% crossval_str_10 = strcat('crossval_',arff_folder{1},'_r1_top10');
% crossenv_str_10 = strcat('crossenv_',arff_folder{1},'_r1_top10');
% 
% 
% for fld=2:length(arff_folder)
%     for cur_rnd = {'10' '20' '30' '40' '50' '60'};
%         crossval_str=strcat(crossval_str,'; ','crossval_',arff_folder{fld},'_r1_top',char(cur_rnd));
%         crossenv_str=strcat(crossval_str,'; ','crossenv_',arff_folder{fld},'_r1_top',char(cur_rnd));
%     end
% end
% 
% crossval_str = strcat('[ ', crossval_str, ']');
% crossenv_str = strcat('[ ', crossenv_str, ']');

% [crossval_12345_r1_top10,crossenv_12345_r1_top10]=RunResultsScript_BigEnvs_SenSys(rnd, '12345', 10);
% [crossval_12345_r1_top20,crossenv_12345_r1_top20]=RunResultsScript_BigEnvs_SenSys(rnd, '12345', 20);
% [crossval_12345_r1_top30,crossenv_12345_r1_top30]=RunResultsScript_BigEnvs_SenSys(rnd, '12345', 30);
% [crossval_12345_r1_top40,crossenv_12345_r1_top40]=RunResultsScript_BigEnvs_SenSys(rnd, '12345', 40);
% [crossval_12345_r1_top50,crossenv_12345_r1_top50]=RunResultsScript_BigEnvs_SenSys(rnd, '12345', 50);
% [crossval_12345_r1_top60,crossenv_12345_r1_top60]=RunResultsScript_BigEnvs_SenSys(rnd, '12345', 60);
% 
% [crossval_123410_r1_top10,crossenv_123410_r1_top10]=RunResultsScript_BigEnvs_SenSys(rnd, '123410', 10);
% [crossval_123410_r1_top20,crossenv_123410_r1_top20]=RunResultsScript_BigEnvs_SenSys(rnd, '123410', 20);
% [crossval_123410_r1_top30,crossenv_123410_r1_top30]=RunResultsScript_BigEnvs_SenSys(rnd, '123410', 30);
% [crossval_123410_r1_top40,crossenv_123410_r1_top40]=RunResultsScript_BigEnvs_SenSys(rnd, '123410', 40);
% [crossval_123410_r1_top50,crossenv_123410_r1_top50]=RunResultsScript_BigEnvs_SenSys(rnd, '123410', 50);
% [crossval_123410_r1_top60,crossenv_123410_r1_top60]=RunResultsScript_BigEnvs_SenSys(rnd, '123410', 60);
% 
% [crossval_123510_r1_top10,crossenv_123510_r1_top10]=RunResultsScript_BigEnvs_SenSys(rnd, '123510', 10);
% [crossval_123510_r1_top20,crossenv_123510_r1_top20]=RunResultsScript_BigEnvs_SenSys(rnd, '123510', 20);
% [crossval_123510_r1_top30,crossenv_123510_r1_top30]=RunResultsScript_BigEnvs_SenSys(rnd, '123510', 30);
% [crossval_123510_r1_top40,crossenv_123510_r1_top40]=RunResultsScript_BigEnvs_SenSys(rnd, '123510', 40);
% [crossval_123510_r1_top50,crossenv_123510_r1_top50]=RunResultsScript_BigEnvs_SenSys(rnd, '123510', 50);
% [crossval_123510_r1_top60,crossenv_123510_r1_top60]=RunResultsScript_BigEnvs_SenSys(rnd, '123510', 60);
% 
% [crossval_124510_r1_top10,crossenv_124510_r1_top10]=RunResultsScript_BigEnvs_SenSys(rnd, '124510', 10);
% [crossval_124510_r1_top20,crossenv_124510_r1_top20]=RunResultsScript_BigEnvs_SenSys(rnd, '124510', 20);
% [crossval_124510_r1_top30,crossenv_124510_r1_top30]=RunResultsScript_BigEnvs_SenSys(rnd, '124510', 30);
% [crossval_124510_r1_top40,crossenv_124510_r1_top40]=RunResultsScript_BigEnvs_SenSys(rnd, '124510', 40);
% [crossval_124510_r1_top50,crossenv_124510_r1_top50]=RunResultsScript_BigEnvs_SenSys(rnd, '124510', 50);
% [crossval_124510_r1_top60,crossenv_124510_r1_top60]=RunResultsScript_BigEnvs_SenSys(rnd, '124510', 60);
% 
% [crossval_134510_r1_top10,crossenv_134510_r1_top10]=RunResultsScript_BigEnvs_SenSys(rnd, '134510', 10);
% [crossval_134510_r1_top20,crossenv_134510_r1_top20]=RunResultsScript_BigEnvs_SenSys(rnd, '134510', 20);
% [crossval_134510_r1_top30,crossenv_134510_r1_top30]=RunResultsScript_BigEnvs_SenSys(rnd, '134510', 30);
% [crossval_134510_r1_top40,crossenv_134510_r1_top40]=RunResultsScript_BigEnvs_SenSys(rnd, '134510', 40);
% [crossval_134510_r1_top50,crossenv_134510_r1_top50]=RunResultsScript_BigEnvs_SenSys(rnd, '134510', 50);
% [crossval_134510_r1_top60,crossenv_134510_r1_top60]=RunResultsScript_BigEnvs_SenSys(rnd, '134510', 60);
% 
% [crossval_234510_r1_top10,crossenv_234510_r1_top10]=RunResultsScript_BigEnvs_SenSys(rnd, '234510', 10);
% [crossval_234510_r1_top20,crossenv_234510_r1_top20]=RunResultsScript_BigEnvs_SenSys(rnd, '234510', 20);
% [crossval_234510_r1_top30,crossenv_234510_r1_top30]=RunResultsScript_BigEnvs_SenSys(rnd, '234510', 30);
% [crossval_234510_r1_top40,crossenv_234510_r1_top40]=RunResultsScript_BigEnvs_SenSys(rnd, '234510', 40);
% [crossval_234510_r1_top50,crossenv_234510_r1_top50]=RunResultsScript_BigEnvs_SenSys(rnd, '234510', 50);
% [crossval_234510_r1_top60,crossenv_234510_r1_top60]=RunResultsScript_BigEnvs_SenSys(rnd, '234510', 60);
% 
% final_crossval_10 = [ crossval_12345_r1_top10; crossval_123410_r1_top10; crossval_123510_r1_top10; crossval_124510_r1_top10; crossval_134510_r1_top10; crossval_234510_r1_top10 ];
% final_crossval_20 = [ crossval_12345_r1_top20; crossval_123410_r1_top20; crossval_123510_r1_top20; crossval_124510_r1_top20; crossval_134510_r1_top20; crossval_234510_r1_top20 ];
% final_crossval_30 = [ crossval_12345_r1_top30; crossval_123410_r1_top30; crossval_123510_r1_top30; crossval_124510_r1_top30; crossval_134510_r1_top30; crossval_234510_r1_top30 ];
% final_crossval_40 = [ crossval_12345_r1_top40; crossval_123410_r1_top40; crossval_123510_r1_top40; crossval_124510_r1_top40; crossval_134510_r1_top40; crossval_234510_r1_top40 ];
% final_crossval_50 = [ crossval_12345_r1_top50; crossval_123410_r1_top50; crossval_123510_r1_top50; crossval_124510_r1_top50; crossval_134510_r1_top50; crossval_234510_r1_top50 ];
% final_crossval_60 = [ crossval_12345_r1_top60; crossval_123410_r1_top60; crossval_123510_r1_top60; crossval_124510_r1_top60; crossval_134510_r1_top60; crossval_234510_r1_top60 ];
% 
% final_crossenv_10 = [ crossenv_12345_r1_top10; crossenv_123410_r1_top10; crossenv_123510_r1_top10; crossenv_124510_r1_top10; crossenv_134510_r1_top10; crossenv_234510_r1_top10 ];
% final_crossenv_20 = [ crossenv_12345_r1_top20; crossenv_123410_r1_top20; crossenv_123510_r1_top20; crossenv_124510_r1_top20; crossenv_134510_r1_top20; crossenv_234510_r1_top20 ];
% final_crossenv_30 = [ crossenv_12345_r1_top30; crossenv_123410_r1_top30; crossenv_123510_r1_top30; crossenv_124510_r1_top30; crossenv_134510_r1_top30; crossenv_234510_r1_top30 ];
% final_crossenv_40 = [ crossenv_12345_r1_top40; crossenv_123410_r1_top40; crossenv_123510_r1_top40; crossenv_124510_r1_top40; crossenv_134510_r1_top40; crossenv_234510_r1_top40 ];
% final_crossenv_50 = [ crossenv_12345_r1_top50; crossenv_123410_r1_top50; crossenv_123510_r1_top50; crossenv_124510_r1_top50; crossenv_134510_r1_top50; crossenv_234510_r1_top50 ];
% final_crossenv_60 = [ crossenv_12345_r1_top60; crossenv_123410_r1_top60; crossenv_123510_r1_top60; crossenv_124510_r1_top60; crossenv_134510_r1_top60; crossenv_234510_r1_top60 ];