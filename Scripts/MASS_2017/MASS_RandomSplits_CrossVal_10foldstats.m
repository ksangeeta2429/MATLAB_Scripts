function Results=MASS_RandomSplits_CrossVal_10foldstats(round,seed,topk_list)

SetEnvironment
SetPath

outFileName = strcat('CrossVal_SaveAllModels_Round',num2str(round),'.csv');
path_to_round_folder = strcat(g_str_pathbase_radar,'/IIITDemo/Arff/Randseed',num2str(seed),'/Round',num2str(round));
path_models = g_str_pathbase_model;

cd(path_to_round_folder);

d = dir;
isub = [d(:).isdir]; %# returns logical vector
nameFolds = {d(isub).name}';
nameFolds(ismember(nameFolds,{'.','..'})) = [];

Results={};
for topk=topk_list
    for i=1:length(nameFolds)
        path_to_arff_combos = strcat(path_to_round_folder,'/',char(nameFolds{i}),'/top',num2str(topk));
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
            for c=[0.001 0.01 0.1 1 10 100 1000 100000 1000000] %[1 2 3 4 5 6 7 8 9 10 20 30 40 50 60 70 80 90 100]
                for gamma=[0.001 0.01 0.05 0.1 0.5 1 5 10] %[0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.1]
                    fprintf('\tAttempting with c=%d, gamma=%d\n', c, gamma);
                    accuracy_arr=CrossVal_10foldstats_new(path_models,path_combined_env,c, gamma, 1);
                    Results = [Results; num2cell(topk), nameFolds{i}, nameFilters{j}, num2cell(c), num2cell(gamma), num2cell(accuracy_arr)];
                end
            end
        end
    end
end

cell2csv(strcat(path_to_round_folder,'/',outFileName), Results);