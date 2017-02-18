function [crossval_InfoGain,crossenvironment_InfoGain]=InfoGain_PCT(round, top_k)

SetEnvironment
SetPath

path_to_top_level = strcat(g_str_pathbase_radar,'/IIITDemo/Arff/BigEnvs/Round',num2str(round));

%% Populate arff folder names
cd(path_to_top_level);
fileFullNames=dir;
i=1;
arffFolders={};
for j=1:length(fileFullNames)
    if(fileFullNames(j).isdir && not(isempty(regexp(fileFullNames(j).name,'\.', 'once'))))
        arffFolders{i}=fileFullNames(j).name;
        i=i+1;
    end
end

%% Process individual folders
parfor arff_folder=1:length(arff_folderlist)
    path_to_scaled_arffs = strcat(path_to_top_level,'/',num2str(arff_folder));
    path_to_combined_arff_scaled = strcat(path_to_scaled_arffs,'/combined');
    path_to_test_arffs = strcat(path_to_scaled_arffs,'/test');
    
    path_to_topk_arffs_scaled = strcat(path_to_scaled_arffs,strcat('/top',num2str(top_k))); % '\top20' or '\top10', depending on which top-k feature set you want
    path_to_InfoGain_arffs = strcat(path_to_topk_arffs_scaled,'/InfoGain_combined'); % combined file
    
    path_to_topk_test = strcat(path_to_test_arffs,strcat('/top',num2str(top_k)));
    path_to_InfoGain_test = strcat(path_to_topk_test,'/InfoGain_combined');
    
    %Create InfoGain features folder if it doesn't  exist
    if exist(path_to_InfoGain_arffs, 'dir') ~= 7
        mkdir(path_to_InfoGain_arffs); % Includes path_to_topk_arffs_scaled
        fprintf('INFO: created directory %s\n', path_to_InfoGain_arffs);
    end
    
    if exist(path_to_InfoGain_test, 'dir') ~= 7
        mkdir(path_to_InfoGain_test); % Includes path_to_topk_arffs_scaled
        fprintf('INFO: created directory %s\n', path_to_InfoGain_test);
    end
    
    % Attribute selection for top_k Information Gain ranked features
    fprintf('Computing Information Gain feature selection\n');
    fprintf('--------------------------------------------\n');
    [InfoGain_features,~,~,~] = InformationGainOfAFeatureOfAFile_weka(path_to_combined_arff_scaled,top_k);
    fprintf('--------------------------------------------\n\n');
    
    InfoGain_features_file_suffix = sprintf('%.0f_',InfoGain_features);
    InfoGain_features_file_suffix = strcat('f_', InfoGain_features_file_suffix(1:end-1));
    
    InfoGain_features_csv = sprintf('%.0f,' , InfoGain_features);
    InfoGain_features_csv = InfoGain_features_csv(1:end-1);
    
    % Create downsized output files -- top_k Information Gain features
    % Training files
    cd(path_to_combined_arff_scaled);
    fileFullNames=dir;
    
    i=1;
    Files={};
    for j=1:length(fileFullNames)
        s=fileFullNames(j).name;
        k=strfind(s,'.arff');
        if ~isempty(k) && k>=2 && k+4==length(s)
            Files{i}=s(1:k-1);
            i=i+1;
        end
    end
    
    for i=1:length(Files) % take every file from the set 'Files'
        infileFullName = strcat(path_to_combined_arff_scaled,'/',Files{i},'.arff');
        outfileName = strcat(path_to_InfoGain_arffs,'/',Files{i},'_', InfoGain_features_file_suffix,'.arff');
        AttributeSelectionManual_Arff(infileFullName, outfileName, InfoGain_features_csv);
    end
    
    % Test files
    cd(path_to_test_arffs);
    testFileFullNames=dir;
    
    i=1;
    testFiles={};
    for j=1:length(testFileFullNames)
        s=testFileFullNames(j).name;
        k=strfind(s,'.arff');
        if ~isempty(k) && k>=2 && k+4==length(s)
            testFiles{i}=s(1:k-1);
            i=i+1;
        end
    end
    
    for i=1:length(testFiles) % take every file from the set 'Files'
        infileFullName = strcat(path_to_test_arffs,'/',testFiles{i},'.arff');
        outfileName = strcat(path_to_InfoGain_test,'/',testFiles{i},'_', InfoGain_features_file_suffix,'.arff');
        AttributeSelectionManual_Arff(infileFullName, outfileName, InfoGain_features_csv);
    end
end

%% TODO: UNCOMMENT!!!

% %% Generate models for top_k Information Gain features
% fprintf('Generating models for Information Gain ranked features\n');
% fprintf('------------------------------------------------------\n');
% crossval_InfoGain = GenerateModels_Parallel_IoTDI(g_str_pathbase_model, path_to_top_level);
% fprintf('------------------------------------------------------\n\n');

% %% Generate cross-environment results from stored models
% fprintf('Generating cross-environment validation from Information Gain ranked features\n');
% fprintf('-----------------------------------------------------------------------------\n');
% crossenvironment_InfoGain = GenerateCrossEnvironmentResults_IoTDI(g_str_pathbase_model, path_to_InfoGain_arffs, path_to_InfoGain_test);
% % crossenvironment_InfoGain = GenerateCrossEnvironmentResults_IoTDI(g_str_pathbase_model, path_to_InfoGain_arffs, path_to_InfoGain_test);
% fprintf('-----------------------------------------------------------------------------\n\n');

