function Result=MASS_Optimize_MAD_Beta_Crossval(round,filter_type,metric_type,prctile_param)

if not(isempty(strfind(lower(filter_type),'mrmr')))
    path_to_round_folder = strcat('~/Dropbox/TransferPCtoMac/mRMR_and_MAD/Round',num2str(round));
    filters={'mRMR_D_combined', 'mRMRMAD_D_0_25s', 'mRMRMAD_D_0_5s', 'mRMRMAD_D_0_75s', 'mRMRMAD_D_1s', 'mRMRMAD_D_5s', 'mRMRMAD_D_10s', 'mRMRMAD_D_20s', 'mRMRMAD_D_50s'};
else
    path_to_round_folder = strcat('~/Dropbox/TransferPCtoMac/InfoGain_and_MAD/Round',num2str(round));
    filters={'InfoGain_combined', 'InfoGainMAD_0_25s', 'InfoGainMAD_0_5s', 'InfoGainMAD_0_75s', 'InfoGainMAD_1s', 'InfoGainMAD_5s', 'InfoGainMAD_10s', 'InfoGainMAD_20s', 'InfoGainMAD_50s'};
end

cd(path_to_round_folder);
envs=table2struct(readtable('env_processing_order.csv','Delimiter',',','ReadVariableNames',false));

M={};
for topk=10:5:40
    crossvals=dlmread(strcat('crossval_str_',num2str(topk),'.csv'));
    for i=1:length(envs)
        for j=1:length(filters)
            M=[M;{topk,envs(i).Var1,filters{j},crossvals(i,j)}];
        end
    end
end
        
Result={};
for i=2:9:length(M)
    arr = [];
    for j=i:i+7
        arr=[arr,M{j,4}];
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
        if M{j,4}==metric
            Result=[Result;{M{j,1},M{j,2},M{j,3}}];
            break
        end
    end
end