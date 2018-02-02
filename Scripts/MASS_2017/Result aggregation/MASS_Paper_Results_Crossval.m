function [Median,IQR,OpPoint,HighOpPoint]=MASS_Paper_Results_Crossval(round,topk_array,filter_type,metric_type,prctile,testenvs)
%set(0,'DefaultFigureVisible','off');
SetEnvironment
SetPath

if not(~contains(lower(filter_type),'mrmr'))
    path_to_round_folder = strcat('~/Research/Robust_Learning_Radar/Results/CrossValidation_Regular/mRMR_and_MAD/Round',num2str(round));
else
    path_to_round_folder = strcat('~/Research/Robust_Learning_Radar/Results/CrossValidation_Regular/InfoGain_and_MAD/Round',num2str(round));
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
        elseif strcmpi(testenvs,'all')==0....
                &&(not(isempty(strfind(M(i).Var2,'10'))) || not(isempty(strfind(M(i).Var2,'2')))|| not(isempty(strfind(M(i).Var2,'1'))))....
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
%     plot_orig(:,k) = orig_array;
%     plot_mad(:,k) = mad_array;
%     k=k+1;
%     oppoints_orig(topk)=median(orig_array)-iqr(orig_array)/2;
%     oppoints_mad(topk)=median(mad_array)-iqr(mad_array)/2;
    
    medians_topk(1,k)=median(orig_array);
    medians_topk(2,k)=median(mad_array);
    
    errors_topk(1,k)=iqr(orig_array)/2;
    errors_topk(2,k)=iqr(mad_array)/2;
    
    Labels{k}=num2str(topk);
    k=k+1;
    
    Median=[Median;[{topk},{median(orig_array)}, {median(mad_array)}]];
    IQR=[IQR;[{topk},{iqr(orig_array)}, {iqr(mad_array)}]];
    OpPoint=[OpPoint;[{topk},{median(orig_array)-iqr(orig_array)/2}, {median(mad_array)-iqr(mad_array)/2}]];
    HighOpPoint=[HighOpPoint;[{topk},{median(orig_array)+iqr(orig_array)/2}, {median(mad_array)+iqr(mad_array)/2}]];
end

%g = bar(medians_topk(1,:),'FaceColor',[0 .5 .5],'EdgeColor','black');
g=errorbar(topk_array, medians_topk(1,:), errors_topk(1,:),'-s','MarkerSize',10,...
    'MarkerEdgeColor','red','MarkerFaceColor','red');
g.Color = 'black';
grid on
hold on
p=errorbar(topk_array, medians_topk(2,:), errors_topk(2,:),'-s','MarkerSize',10,...
    'MarkerEdgeColor','blue','MarkerFaceColor','blue');
p.Color = 'red';
hold off
l=cell(1,2);
% l{1}='InfoGain'; l{2}='mRMR'; l{3}='minEnvs'; l{4}='MAD';
l{1}=filter_type; l{2}=strcat(filter_type,'\_MAD');

h=gca;
legend(h,l,'Location','northwest','interpreter','latex');
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
ylim([-inf 100]);
xlim([0 50]);
saveas(h, strcat('~/Research/Robust_Learning_Radar/Results/CrossValidation_Regular/',filter_type,'_and_MAD/',testenvs,'test_',filter_type,'_and_MAD_Envs_',num2str(round),'.fig'));
saveas(h, strcat('~/Research/Robust_Learning_Radar/Results/CrossValidation_Regular/',filter_type,'_and_MAD/',testenvs,'test_',filter_type,'_and_MAD_Envs_',num2str(round),'.eps'), 'eps2c');
% 
% figure
% g = bar(medians_topk(2,:),'FaceColor','yellow','EdgeColor','black');
% grid on
% hold on
% errorbar(medians_topk(2,:), errors_topk(1,:));
% hold off
% l=cell(1,1);
% % l{1}='InfoGain'; l{2}='mRMR'; l{3}='minEnvs'; l{4}='MAD';
% l{1}=strcat(filter_type,'\_MAD');
% legend(g,l,'Location','NorthWest','interpreter','latex');
% 
% h=gca;
% h.TickLabelInterpreter='latex';
% %h.FontName = 'CMU Serif';`
% %h.Interpreter='latex';
% h.FontWeight = 'bold';
% h.FontSize = 20;
% h.XTickLabel=Labels;
% h.XLabel.String = 'Top k Features';
% h.XLabel.Interpreter='latex';
% h.XLabel.FontSize = 30;
% %h.XLabel.FontName = 'CMU Serif';
% h.XLabel.FontWeight = 'bold';
% 
% h.YLabel.String = 'Median Precision';
% h.YLabel.Interpreter='latex';
% h.YLabel.FontSize = 30;
% %h.YLabel.FontName = 'CMU Serif';
% h.YLabel.FontWeight = 'bold';
