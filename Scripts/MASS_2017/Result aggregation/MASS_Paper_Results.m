function [Median,IQR,OpPoint]=MASS_Paper_Results(round,topk_array,training_type)

SetEnvironment
SetPath

path_to_round_folder = strcat(g_str_pathbase_radar,'/IIITDemo/Arff/BigEnvs/Round',num2str(round));
cd(path_to_round_folder);

if lower(training_type)=='crossval'
    eval_csv = ''; % TODO: Fix this later
else % Default: crossenv
    eval_csv = strcat('CrossEnvironment_Evaluation_Round',num2str(round),'.csv');
end

MAD_opt = MASS_Optimize_MAD_Beta(round,training_type);

M=table2struct(readtable(eval_csv,'Delimiter',',','ReadVariableNames',false));

Median={'','Original_filter','MAD_filter'};
IQR={'','Original_filter','MAD_filter'};
OpPoint={'','Original_filter','MAD_filter'};

sentinel=1;
for topk=topk_array
    orig_array = [];
    mad_array = [];
    for i=sentinel:length(M)
        if M(i).Var1 ~= topk
            sentinel = i;
            break;
        end
        if not(isempty(strfind(M(i).Var3,'combined')))
            orig_array = [orig_array,M(i).Var6];
        else
            for j=1:length(MAD_opt)
                if MAD_opt{j,1}==M(i).Var1 && strcmp(MAD_opt{j,2},M(i).Var2)==1 && strcmp(MAD_opt{j,3},M(i).Var3)==1
                    mad_array = [mad_array, M(i).Var6];
                end
            end
        end
    end
    Median=[Median;[{topk},{median(orig_array)}, {median(mad_array)}]];
    IQR=[IQR;[{topk},{iqr(orig_array)}, {iqr(mad_array)}]];
    OpPoint=[OpPoint;[{topk},{median(orig_array)-iqr(orig_array)/2}, {median(mad_array)-iqr(mad_array)/2}]];
end