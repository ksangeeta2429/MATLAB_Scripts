function Results=MASS_TestEnvs_script(round,topk_list, training_type)

SetEnvironment
SetPath

outFileName = strcat('CrossEnvironment_Evaluation_Round',num2str(round),'.csv');

if lower(training_type) == 'crossval'
    path_models = g_str_pathbase_model;
else % Default: crossenvironment validation
    %path_models = strcat(g_str_pathbase_model,'/Crossenv_vals');
end

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
        path_test_envs = strcat(path_to_round_folder,'/',char(nameFolds{i}),'/test');
        cd(path_to_arff_combos);
        
        % Get filter names
        d = dir;
        isub = [d(:).isdir]; %# returns logical vector
        nameFilters = {d(isub).name}';
        nameFilters(ismember(nameFilters,{'.','..'})) = [];
        
        for j=1:length(nameFilters)
            path_combined_env = strcat(path_to_arff_combos,'/',nameFilters{j});
            
            %Create model folder if it doesn't exist
            if exist(path_models, 'dir') ~= 7
                mkdir(path_models); % Includes path_to_topk_arffs_scaled
                fprintf('INFO: created directory %s\n', path_models);
            end
            
            Results = [Results; GenerateCrossEnvironmentResults_HumanOnly_MASS(num2cell(topk), nameFolds{i}, nameFilters{j}, path_models, path_combined_env, path_test_envs)];
        end
    end
end

cell2csv(strcat(path_to_round_folder,'/',outFileName), Results);