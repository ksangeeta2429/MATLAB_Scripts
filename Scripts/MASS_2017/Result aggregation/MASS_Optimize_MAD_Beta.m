function Result=MASS_Optimize_MAD_Beta(round,training_type)

SetEnvironment
SetPath

path_to_round_folder = strcat(g_str_pathbase_radar,'/IIITDemo/Arff/BigEnvs/Round',num2str(round));
cd(path_to_round_folder);

if lower(training_type)=='crossval'
    training_csv = ''; % TODO: Fix this later
else % Default: crossenv
    training_csv = strcat('CrossEnvironment_validation_Round',num2str(round),'.csv');
end

M=table2struct(readtable(training_csv,'Delimiter',',','ReadVariableNames',false));

Result={};
for i=1:9:length(M)
    arr = [];
    for j=i:i+7
        arr=[arr,M(j).Var7];
    end
    metric = min(arr(arr>=max(arr)));
    for j=i:i+7
        if M(j).Var7==metric
            Result=[Result;[{M(i).Var1},{M(i).Var2},{M(j).Var3}]];
            break
        end
    end
end
    