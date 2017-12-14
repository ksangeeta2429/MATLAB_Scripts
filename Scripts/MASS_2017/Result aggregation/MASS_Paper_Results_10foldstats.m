function [Median,IQR,OpPoint,HighOpPoint]=MASS_Paper_Results_10foldstats(round,topk_array,filter_type,testenvs)
%set(0,'DefaultFigureVisible','off');
SetEnvironment
SetPath

path_to_round_folder = strcat(g_str_pathbase_radar,'/Results/CrossValidation_10foldstats/Environment_Splits/Round',num2str(round));
cd(path_to_round_folder);

[Orig_opt,MAD_opt] = MASS_Optimize_MAD_Beta_10foldstats(round,topk_array,filter_type);

Median={'','Original_filter','MAD_filter'};
IQR={'','Original_filter','MAD_filter'};
OpPoint={'','Original_filter','MAD_filter'};
HighOpPoint={'','Original_filter','MAD_filter'};
k=1;
for topk=topk_array
    eval_csv = strcat('CrossEnvironment_Evaluation_10foldstats_Round',num2str(round),'_Top',num2str(topk),'.csv');
    M=table2struct(readtable(eval_csv,'Delimiter',',','ReadVariableNames',false));
    
    orig_array = [];
    mad_array = [];
    for i=1:length(M)
        if strcmpi(testenvs,'all')==0....
                &&(not(isempty(strfind(M(i).Var2,'10'))) || not(isempty(strfind(M(i).Var2,'2')))|| not(isempty(strfind(M(i).Var2,'1'))))....
                && (strcmp(M(i).Var5(strfind(M(i).Var5,'radar')+5:strfind(M(i).Var5,'_')-1),'10')==1 || ....
                strcmp(M(i).Var5(strfind(M(i).Var5,'radar')+5:strfind(M(i).Var5,'_')-1),'2')==1 ||....
                strcmp(M(i).Var5(strfind(M(i).Var5,'radar')+5:strfind(M(i).Var5,'_')-1),'1')==1)% 1,2,10 can't be in train/test
            continue
        end
        if not(isempty(strfind(M(i).Var3,'combined')))
            for j=1:length(Orig_opt)
                if Orig_opt{j,1}==M(i).Var1 && strcmp(Orig_opt{j,2},M(i).Var2)==1 && strcmp(Orig_opt{j,3},M(i).Var3)==1 && strcmp(Orig_opt{j,4},num2str(M(i).Var7))==1 && strcmp(Orig_opt{j,5},num2str(M(i).Var8))==1
                    orig_array = [orig_array, M(i).Var6];
                end
            end
            for j=1:length(MAD_opt)
                if MAD_opt{j,1}==M(i).Var1 && strcmp(MAD_opt{j,2},M(i).Var2)==1 && strcmp(MAD_opt{j,3},M(i).Var3)==1 && strcmp(MAD_opt{j,4},num2str(M(i).Var7))==1 && strcmp(MAD_opt{j,5},num2str(M(i).Var8))==1
                    mad_array = [mad_array, M(i).Var6];
                end
            end
        else
            for j=1:length(MAD_opt)
                if MAD_opt{j,1}==M(i).Var1 && strcmp(MAD_opt{j,2},M(i).Var2)==1 && strcmp(MAD_opt{j,3},M(i).Var3)==1 && strcmp(MAD_opt{j,4},num2str(M(i).Var7))==1 && strcmp(MAD_opt{j,5},num2str(M(i).Var8))==1
                    mad_array = [mad_array, M(i).Var6];
                end
            end
        end
    end
%     plot_orig(:,k) = orig_array;
%     plot_mad(:,k) = mad_array;
%     k=k+1;
%     oppoints_orig(topk)=median(orig_array)-iqr(orig_array)/2;
%     oppoints_mad(topk)=median(mad_array)-iqr(mad_array)/2;
    
    medians_topk(1,k)=median(orig_array);
    medians_topk(2,k)=median(mad_array);
    
    errors_topk(1,k)=iqr(orig_array)/2;
    errors_topk(2,k)=iqr(mad_array)/2;
    
    errors_neg_topk(1,k)=median(orig_array)-quantile(orig_array,0.25);
    errors_neg_topk(2,k)=median(mad_array)-quantile(mad_array,0.25);
    
    errors_pos_topk(1,k)=quantile(orig_array,0.75)-median(orig_array);
    errors_pos_topk(2,k)=quantile(mad_array,0.75)-median(mad_array);
    
    Labels{k}=num2str(topk);
    k=k+1;
    
    Median=[Median;[{topk},{median(orig_array)}, {median(mad_array)}]];
    IQR=[IQR;[{topk},{iqr(orig_array)}, {iqr(mad_array)}]];
    OpPoint=[OpPoint;[{topk},{median(orig_array)-iqr(orig_array)/2}, {median(mad_array)-iqr(mad_array)/2}]];
    HighOpPoint=[HighOpPoint;[{topk},{median(orig_array)+iqr(orig_array)/2}, {median(mad_array)+iqr(mad_array)/2}]];
end

%g = bar(medians_topk(1,:),'FaceColor',[0 .5 .5],'EdgeColor','black');
g=errorbar(topk_array, medians_topk(1,:), errors_neg_topk(1,:),errors_pos_topk(1,:),'-s','MarkerSize',10,...
    'MarkerEdgeColor','red','MarkerFaceColor','red');
g.Color = 'red';
grid on
hold on
p=errorbar(topk_array+0.5, medians_topk(2,:), errors_neg_topk(2,:),errors_pos_topk(2,:),'-s','MarkerSize',10,...
    'MarkerEdgeColor','blue','MarkerFaceColor','blue');
p.Color = 'blue';
hold off
l=cell(1,2);
% l{1}='InfoGain'; l{2}='mRMR'; l{3}='minEnvs'; l{4}='MAD';
l{1}=filter_type; l{2}=strcat(filter_type,'\_MAD');

h=gca;
legend(h,l,'Location','southeast','interpreter','latex');
%legend boxoff
h.TickLabelInterpreter='latex';
%h.FontName = 'CMU Serif';`
%h.Interpreter='latex';
h.FontWeight = 'bold';
h.FontSize = 20;
h.XLabel.String = 'Top k Features';
h.XLabel.Interpreter='latex';
h.XLabel.FontSize = 30;
%h.XLabel.FontName = 'CMU Serif';
h.XLabel.FontWeight = 'bold';

h.YLabel.String = 'Median Precision';
h.YLabel.Interpreter='latex';
h.YLabel.FontSize = 30;
%h.YLabel.FontName = 'CMU Serif';
h.YLabel.FontWeight = 'bold';
ylim([20 100]);
xlim([5 40]);
saveas(h, strcat(g_str_pathbase_radar,'/Results/CrossValidation_10foldstats/Environment_Splits/',testenvs,'test_',filter_type,'_and_MAD_Envs_',num2str(round),'.fig'));