function [Median,IQR,OpPoint,HighOpPoint]=MASS_Paper_Results_Crossval(round,topk_array,filter_type,metric_type,prctile)

SetEnvironment
SetPath

if not(isempty(strfind(lower(filter_type),'mrmr')))
    path_to_round_folder = strcat('~/Dropbox/TransferPCtoMac/mRMR_and_MAD/Round',num2str(round));
else
    path_to_round_folder = strcat('~/Dropbox/TransferPCtoMac/InfoGain_and_MAD/Round',num2str(round));
end
cd(path_to_round_folder);


eval_csv = strcat('CrossEnvironment_Evaluation_Round',num2str(round),'.csv');

MAD_opt = MASS_Optimize_MAD_Beta_Crossval(round,filter_type,metric_type,prctile);

M=table2struct(readtable(eval_csv,'Delimiter',',','ReadVariableNames',false));

Median={'','Original_filter','MAD_filter'};
IQR={'','Original_filter','MAD_filter'};
OpPoint={'','Original_filter','MAD_filter'};
HighOpPoint={'','Original_filter','MAD_filter'};
sentinel=1;
k=1;
for topk=topk_array
    orig_array = [];
    mad_array = [];
    for i=sentinel:length(M)
        if M(i).Var1 ~= topk
            sentinel = i;
            break;
        elseif (not(isempty(strfind(M(i).Var2,'10'))) || not(isempty(strfind(M(i).Var2,'2')))|| not(isempty(strfind(M(i).Var2,'1'))))....
                && (strcmp(M(i).Var5(strfind(M(i).Var5,'radar')+5:strfind(M(i).Var5,'_')-1),'10')==1 || ....
                strcmp(M(i).Var5(strfind(M(i).Var5,'radar')+5:strfind(M(i).Var5,'_')-1),'2')==1 ||....
                strcmp(M(i).Var5(strfind(M(i).Var5,'radar')+5:strfind(M(i).Var5,'_')-1),'1')==1)% 1,2,3 can't be in train/test
            continue
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
    plot_orig(:,k) = orig_array;
    plot_mad(:,k) = mad_array;
    k=k+1;
    %boxplot([orig_array',mad_array'],'Labels',{'mu = 5','mu = 6'});
    Median=[Median;[{topk},{median(orig_array)}, {median(mad_array)}]];
    IQR=[IQR;[{topk},{iqr(orig_array)}, {iqr(mad_array)}]];
    OpPoint=[OpPoint;[{topk},{median(orig_array)-iqr(orig_array)/2}, {median(mad_array)-iqr(mad_array)/2}]];
    HighOpPoint=[HighOpPoint;[{topk},{median(orig_array)+iqr(orig_array)/2}, {median(mad_array)+iqr(mad_array)/2}]];
end