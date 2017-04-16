function Results = GenerateModels_CrossEnv_MASS(path_models,path_single_envs, path_combined_env)

% Find combined env file name
combFile = dir(strcat(path_combined_env,'/*.arff'));
fileName = combFile(1).name;

accuracy_max = 0;
c_max=0;
gamma_max=0;

for c=[0.001 0.01 0.1 1 10 100 1000 100000 1000000] %[1 2 3 4 5 6 7 8 9 10 20 30 40 50 60 70 80 90 100]
    for gamma=[0.001 0.01 0.05 0.1 0.5 1 5 10] %[0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.1]
        fprintf('\tAttempting with c=%d, gamma=%d\n', c, gamma);
        [~, accuracy] = Crossenv_val_new(path_models,path_single_envs, path_combined_env, c, gamma, 0);
        %accuracy = (confusionmatrix(1,1) + confusionmatrix(2,2))/totalNumInstances;
        %accuracy = (confusionmatrix(1,1) + confusionmatrix(2,2));
        if (accuracy >= accuracy_max) % >= and not >, since we want maximum beta for MAD
            accuracy_max = accuracy;
            c_max = c;
            gamma_max =gamma;
        end
    end
end
fprintf('\tGenerating model with c_max=%d, gamma_max=%d, accuracy=%f%%\n', c_max, gamma_max, accuracy_max);
Crossenv_val_new(path_models,path_single_envs, path_combined_env, c_max, gamma_max,1)'; % renew the model txt file

Results=[{fileName}, c_max, gamma_max, accuracy_max];