function Result=MASS_Optimize_MAD_Beta(round,training_type,metric_type,prctile_param)

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
    if strcmpi(metric_type,'max')==1
        metric = min(arr(arr>=max(arr)));
    elseif strcmpi(metric_type,'min')==1
        metric = min(arr(arr>=min(arr)));
    elseif strcmpi(metric_type,'median')==1
        metric = min(arr(arr>=median(arr)));
    elseif strcmpi(metric_type,'prctile')==1
        metric = min(arr(arr>=prctile(arr,prctile_param)));
    end
    
    for j=i:i+7
        if M(j).Var7==metric
            Result=[Result;[{M(i).Var1},{M(i).Var2},{M(j).Var3}]];
            break
        end
    end
end
