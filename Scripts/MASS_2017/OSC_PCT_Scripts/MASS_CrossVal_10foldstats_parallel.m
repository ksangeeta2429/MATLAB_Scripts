function Results=MASS_CrossVal_10foldstats_parallel(round,topk_list)

SetEnvironment
SetPath

outFileName = strcat('CrossVal_SaveAllModels_Round',num2str(round),'.csv');
path_to_round_folder = strcat(g_str_pathbase_radar,'/IIITDemo/Arff/BigEnvs/Round',num2str(round));
path_models = g_str_pathbase_model;

cd(path_to_round_folder);

d = dir;
isub = [d(:).isdir]; %# returns logical vector
nameFolds = {d(isub).name}';
nameFolds(ismember(nameFolds,{'.','..'})) = [];

%% Populate c-gamma combos
i = 1;
for c=[0.001 0.01 0.1 1 10 100 1000 100000 1000000]
    for gamma=[0.001 0.01 0.05 0.1 0.5 1 5 10]
        comb_c_gamma{i} = [c gamma];
        i=i+1;
    end
end

Results={};
for topk=topk_list
    for i=1:length(nameFolds)
        path_to_arff_combos = strcat(path_to_round_folder,'/',char(nameFolds{i}),'/top',num2str(topk));
        fold_name=nameFolds{i};
        cd(path_to_arff_combos);
        
        % Get filter names
        d = dir;
        isub = [d(:).isdir]; %# returns logical vector
        nameFilters = {d(isub).name}';
        nameFilters(ismember(nameFilters,{'.','..'})) = [];
        
        for j=1:length(nameFilters)
            path_combined_env = strcat(path_to_arff_combos,'/',nameFilters{j});
            filter_name=nameFilters{j};
            
            %Create model folder if it doesn't exist
            if exist(path_models, 'dir') ~= 7
                mkdir(path_models); % Includes path_to_topk_arffs_scaled
                fprintf('INFO: created directory %s\n', path_models);
            end
            
            Results_par = zeros(length(comb_c_gamma),12);
            parfor k=1:length(comb_c_gamma)
                cur = comb_c_gamma{k};
                c = cur(1);
                gamma=cur(2);
                fprintf('\tAttempting with c=%d, gamma=%d\n', c, gamma);
                accuracy_arr=CrossVal_10foldstats_new(path_models,path_combined_env,c, gamma, 1);
                res_arr = [c gamma accuracy_arr];
                Results_par(k,:)=res_arr;
            end
            
            % Populate Results
            for l=1:length(comb_c_gamma)
                Results = [Results; num2cell(topk), nameFolds{i}, nameFilters{j}, num2cell(Results_par(l,:))];
            end
        end
    end
end

cell2csv(strcat(path_to_round_folder,'/',outFileName), Results);
