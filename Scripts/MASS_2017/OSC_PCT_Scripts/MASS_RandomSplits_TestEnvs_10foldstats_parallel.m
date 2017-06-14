function MASS_RandomSplits_TestEnvs_10foldstats_parallel(round,seed,topk_list)

SetEnvironment
SetPath

path_models = strcat(g_str_pathbase_model,'/Round',num2str(round));

path_to_round_folder = strcat(g_str_pathbase_radar,'/IIITDemo/Arff/Randseed',num2str(seed),'/Round',num2str(round));

cd(path_to_round_folder);

d = dir;
isub = [d(:).isdir]; %# returns logical vector
nameFolds = {d(isub).name}';
nameFolds(ismember(nameFolds,{'.','..'})) = [];

parfor k=1:length(topk_list)
    topk=topk_list(k);
    Results = {};
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
            
            Results = [Results; GenerateCrossEnvironmentResults_HumanOnly_MASS(num2cell(topk), nameFolds{i}, nameFilters{j}, path_models, path_combined_env, path_test_envs)];
        end
    end
    
    outFileName = strcat('CrossEnvironment_Evaluation_10foldstats_Round',num2str(round),'_Top',num2str(topk),'.csv');
    cell2csv(strcat(path_to_round_folder,'/',outFileName), Results);
end