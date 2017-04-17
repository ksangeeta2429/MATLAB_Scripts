function Results=MASS_CrossEnv_Validation_script(round,topk_list)

SetEnvironment
SetPath

outFileName = strcat('CrossEnvironment_validation_Round',num2str(round),'.csv');
path_to_round_folder = strcat(g_str_pathbase_radar,'/IIITDemo/Arff/BigEnvs/Round',num2str(round));

cd(path_to_round_folder);

d = dir;
isub = [d(:).isdir]; %# returns logical vector
nameFolds = {d(isub).name}';
nameFolds(ismember(nameFolds,{'.','..'})) = [];

Results = {};
for topk=topk_list
    for i=1:length(nameFolds)
        path_to_arff_combos = strcat(path_to_round_folder,'/',char(nameFolds{i}),'/top',num2str(topk));
        path_single_envs = strcat(path_to_round_folder,'/',char(nameFolds{i}),'/single_envs');
        cd(path_to_arff_combos);
        
        % Get filter names
        d = dir;
        isub = [d(:).isdir]; %# returns logical vector
        nameFilters = {d(isub).name}';
        nameFilters(ismember(nameFilters,{'.','..'})) = [];
        
        for j=1:length(nameFilters)
            path_combined_env = strcat(path_to_arff_combos,'/',nameFilters{j});
            
            if not(isempty(strfind(lower(nameFilters{j}),'info'))) % If this is an InfoGains_... filter
                path_models = strcat(g_str_pathbase_model,'/Crossenv_vals/InfoGains_and_MAD');
            else
                path_models = strcat(g_str_pathbase_model,'/Crossenv_vals/mRMR_and_MAD');
            end
            
            %Create model folder if it doesn't exist
            if exist(path_models, 'dir') ~= 7
                mkdir(path_models); % Includes path_to_topk_arffs_scaled
                fprintf('INFO: created directory %s\n', path_models);
            end
            
            Results = [Results; num2cell(topk), nameFolds{i}, nameFilters{j}, GenerateModels_CrossEnv_MASS(path_models,path_single_envs, path_combined_env)];
        end
    end
end

cell2csv(strcat(path_to_round_folder,'/',outFileName), Results);

