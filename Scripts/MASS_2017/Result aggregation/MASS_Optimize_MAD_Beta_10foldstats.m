function [Result_orig,Result_MAD]=MASS_Optimize_MAD_Beta_10foldstats(round,topk_array,filter_type)

path_to_round_folder = strcat('/media/mydrive/Robust_Learning/Results/CrossValidation_10foldstats/Environment_Splits/Round',num2str(round));
if not(isempty(strfind(lower(filter_type),'mrmr')))
    filters={'mRMR_D_combined','mRMRMAD_D_0_25s', 'mRMRMAD_D_0_5s', 'mRMRMAD_D_0_75s', 'mRMRMAD_D_1s', 'mRMRMAD_D_5s', 'mRMRMAD_D_10s', 'mRMRMAD_D_20s', 'mRMRMAD_D_50s'};
else
    filters={'InfoGain_combined','InfoGainMAD_0_25s', 'InfoGainMAD_0_5s', 'InfoGainMAD_0_75s', 'InfoGainMAD_1s', 'InfoGainMAD_5s', 'InfoGainMAD_10s', 'InfoGainMAD_20s', 'InfoGainMAD_50s'};
end

cd(path_to_round_folder);

Result_orig={};
Result_MAD={};
envs=table2struct(readtable('env_processing_order.csv','Delimiter',',','ReadVariableNames',false));
for topk=topk_array
    M=table2struct(readtable(strcat('CrossVal_SaveAllModels_Round',num2str(round),'_Top',num2str(topk),'.csv'),'Delimiter',',','ReadVariableNames',false));
    for i=1:length(envs)
        % Best params for MAD
        min_score = 999;
        for j=2:length(filters)
            for k=1:length(M)
                if strcmp(M(k).Var2,envs(i).Var1)==1 && strcmp(M(k).Var3,filters{j})==1
                    arr=[M(k).Var6 M(k).Var7 M(k).Var8 M(k).Var9 M(k).Var10 M(k).Var11 M(k).Var12 M(k).Var13 M(k).Var14 M(k).Var15];
                    score=iqr(arr);
                    if score < min_score
                        min_score = score;
                        ResultArr={M(k).Var1, M(k).Var2, M(k).Var3, num2str(M(k).Var4), num2str(M(k).Var5), mean(arr)};
                    end
                end
            end
        end
        Result_MAD=[Result_MAD;ResultArr];
        % Best params for original filter
        max_score = 0;
        for k=1:length(M)
            if strcmp(M(k).Var2,envs(i).Var1)==1 && strcmp(M(k).Var3,filters{1})==1
                arr=[M(k).Var6 M(k).Var7 M(k).Var8 M(k).Var9 M(k).Var10 M(k).Var11 M(k).Var12 M(k).Var13 M(k).Var14 M(k).Var15];
                score=median(arr);
                if score > max_score
                        max_score = score;
                    ResultArr={M(k).Var1, M(k).Var2, M(k).Var3, num2str(M(k).Var4), num2str(M(k).Var5), mean(arr)};
                end
            end
        end
        Result_orig=[Result_orig;ResultArr];
    end
end