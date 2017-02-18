function Results = GenerateCrossEnvironmentResults_IoTDI(path_models, path_train_envs, path_test_envs)
%path_train_envs_nr = strcat(g_str_pathbase_radar,'\IIITDemo\Arff\E1_to_E5_scaled_combos\nr');
%path_test_envs_nr = strcat(path_train_envs_nr,'\test_envs');
%path_models_nr = strcat(g_str_pathbase_radar,'\IIITDemo\Models\E1_to_E5_scaled_combos');

cd(path_train_envs);
fprintf('Entering directory: %s\n',path_train_envs);
fileFullNames=dir;
trainFiles={};  % first 2 file is '.' and '..'
Results = {};
i=1;
for j=1:length(fileFullNames)
    s=fileFullNames(j).name;
    k=strfind(s,'.arff');
    if ~isempty(k) && k>=2 && k+4==length(s) % k+4==length(s) to avoid .data.emf file
        trainFiles{i}=s(1:k-1);
        i=i+1;
    end
end

cd(path_test_envs);
fileFullNames=dir('radar*_scaled_f_*.arff'); % Extract test files: single environments
testFiles={};  % first 2 file is '.' and '..'
i=1;
for j=1:length(fileFullNames)
    s=fileFullNames(j).name;
    k=strfind(s,'.arff');
    if ~isempty(k) && k>=2 && k+4==length(s) % k+4==length(s) to avoid .data.emf file
        testFiles{i}=s(1:k-1);
        i=i+1;
    end
end

for i=1:length(trainFiles) % take every file from the set 'Files'
    fileName=trainFiles{i};
    fprintf('Processing file %s.arff...\n',fileName);
    
    if not(isempty(strfind(fileName,'_e_')))
        if isempty(strfind(fileName,'_f_'))
            fileEnvs_str = fileName(strfind(fileName,'_e_')+3:end);
        else
            fileEnvs_str = fileName(strfind(fileName,'_e_')+3:strfind(fileName,'_f_')-1);
        end
        fileEnvs_str = strrep(fileEnvs_str, '_', ',');
        eval(['temp = {' fileEnvs_str '};']);
        fileEnvs = cell2mat(temp);
    else % Single environment
        fileEnvs = str2num(fileName(strfind(fileName,'radar')+5:strfind(fileName,'_scaled')-1));
    end
    
    for j=1:length(testFiles)
        testFileName  = testFiles{j};
        testFileEnv = str2num(testFileName(strfind(testFileName,'radar')+5:strfind(testFileName,'_scaled')-1));
        
        %% PLEASE REENABLE - Ignore test environment if same as train environment, or is a constituent of the (composite) train environment
%         if strcmp(testFileName, fileName)>0 || not(isempty(find(fileEnvs==testFileEnv)))
%             continue;
%         end
%%        
        
        % modelFile = dir(strcat(path_models,'\',fileName,'*.model'));
        modelFile = dir(strcat(path_models,'/',fileName,'_p_*.model'));
        % result = CrossEnvironmentTestFromModel_new(strrep(strcat('"',path_models,'\',modelFile.name,'"'),'\','\\'), strrep(strcat('"',path_train_envs,'\',testFileName,'.arff"'),'\','\\'));
        result = CrossEnvironmentTestFromModel_new(strcat('"',path_models,'/',modelFile.name,'"'), strcat('"',path_test_envs,'/',testFileName,'.arff"'));
        st = java.util.StringTokenizer(result);
        while(st.hasMoreTokens())
            %fprintf('%s\n',char(st.nextToken()));
            str = char(st.nextToken());
            if strcmp(str,'Correctly')==1
                st.nextToken();
                st.nextToken();
                st.nextToken();
                accuracy = char(st.nextToken());
                break;
            end
        end
        Results = [Results; {fileName}, {testFileName}, str2num(accuracy)];
    end
end

% path_test_envs_r = strcat(g_str_pathbase_radar,'\IIITDemo\Arff\E1_to_E5_scaled_combos\r');
% path_test_envs_r = strcat(path_test_envs_r,'\test_envs');
% path_models_r = strcat(g_str_pathbase_radar,'\IIITDemo\Models\E1_to_E5_scaled_combos');
%
% cd(path_test_envs_r);
% fprintf('Entering directory: %s\n',path_test_envs_r);
% fileFullNames=dir;
% trainFiles={};  % first 2 file is '.' and '..'
% Cross_results_r = {};
% i=1;
% for j=1:length(fileFullNames)
%     s=fileFullNames(j).name;
%     k=strfind(s,'.arff');
%     if ~isempty(k) && k>=2 && k+4==length(s) % k+4==length(s) to avoid .data.emf file
%         trainFiles{i}=s(1:k-1);
%         i=i+1;
%     end
% end
%
% cd(path_test_envs_r);
% fileFullNames=dir;
% testFiles={};  % first 2 file is '.' and '..'
% i=1;
% for j=1:length(fileFullNames)
%     s=fileFullNames(j).name;
%     k=strfind(s,'.arff');
%     if ~isempty(k) && k>=2 && k+4==length(s) % k+4==length(s) to avoid .data.emf file
%         testFiles{i}=s(1:k-1);
%         i=i+1;
%     end
% end
%
% for i=1:length(trainFiles) % take every file from the set 'Files'
%     fileName=trainFiles{i};
%     fprintf('Processing file %s.arff...\n',fileName);
%     for j=1:length(testFiles)
%         testFileName  = testFiles{j};
%         if strcmp(testFileName, fileName)==1
%             continue;
%         end
%          modelFile=dir(strcat(path_models_r,'\',fileName,'*.model'))
%         result = CrossEnvironmentTestFromModel_new(strrep(strcat('"',path_models_r,'\',modelFile.name,'"'),'\','\\'), strrep(strcat('"',path_test_envs_r,'\',testFileName,'.arff"'),'\','\\'));
%         st = java.util.StringTokenizer(result);
%         while(st.hasMoreTokens())
%             %fprintf('%s\n',char(st.nextToken()));
%             str = char(st.nextToken());
%             if strcmp(str,'Correctly')==1
%                 st.nextToken();
%                 st.nextToken();
%                 st.nextToken();
%                 accuracy = char(st.nextToken());
%                 break;
%             end
%         end
%         Cross_results_r = [Cross_results_r; {fileName, testFileName, accuracy}];
%     end
% end


