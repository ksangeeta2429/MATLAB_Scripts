function Results=GenerateCrossEnvironmentResults_HumanOnly_MASS(topk_cell, folder_cell, filter_cell, path_models, path_train_envs, path_test_envs)

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
fileFullNames=dir('radar*_scaled.arff'); % Extract test files: single environments
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

testfolder_filtered=fullfile(path_train_envs,'test');
    
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
        % Ensure that the non-target in test file is represented in the training set
        %         for nt=1:length(nontarget_set)
        %             if not(isempty(find(nontarget_set{nt}==testFileEnv)))
        %                 nttest = nt;
        %                 break;
        %             end
        %         end
        %
        %         flag = 0;
        %         for env=1:length(fileEnvs)
        %             if(not(isempty(find(nontarget_set{nttest}==fileEnvs(env)))))
        %                 flag = 1;
        %                 break;
        %             end
        %         end
        %
        %         if flag==0
        %             continue;
        %         end
        
        
        % modelFile = dir(strcat(path_models,'\',fileName,'*.model'));
        modelFiles = dir(strcat(path_models,'/',fileName,'_p_*.model'));
        % result = CrossEnvironmentTestFromModel_new(strrep(strcat('"',path_models,'\',modelFile.name,'"'),'\','\\'), strrep(strcat('"',path_train_envs,'\',testFileName,'.arff"'),'\','\\'));
        for m=1:length(modelFiles)
            modelFile = modelFiles(m).name;
            str_c_gamma = modelFile(strfind(modelFile,'_p_')+3:strfind(modelFile,'.model')-1);
            c = str2double(str_c_gamma(1:strfind(str_c_gamma,'_')-1));
            gamma=str2double(str_c_gamma(strfind(str_c_gamma,'_')+1:end));
            
            fprintf('Processing test file %s.arff with c=%d,gamma=%d...\n',testFileName,c,gamma);
            result = TestModel_AutoFiltering(strcat(path_models,'/',modelFile), strcat(path_test_envs,'/',testFileName,'.arff'),testfolder_filtered);
            st = java.util.StringTokenizer(result);
            while(st.hasMoreTokens())
                %fprintf('%s\n',char(st.nextToken()));
                str = char(st.nextToken());
                if strcmp(str,'<--')==1
                    st.nextToken();
                    st.nextToken();
                    st.nextToken();
                    st.nextToken();
                    st.nextToken();
                    st.nextToken();
                    st.nextToken();
                    st.nextToken();
                    incorrect = str2double(char(st.nextToken()));
                    correct = str2double(char(st.nextToken()));
                    accuracy=correct/(incorrect+correct)*100;
                    break;
                end
            end
            Results = [Results; topk_cell, folder_cell, filter_cell, {fileName}, {testFileName}, accuracy, c, gamma];
        end
    end
end
