SetEnvironment;
SetPath;

list_algos={'InfoGain_combined',	'mRMR_D_combined', 'mRMR_D_minEnvs_s', 'mRMRMAD_D_0_25s',	'mRMRMAD_D_0_5s',	'mRMRMAD_D_0_75s',	'mRMRMAD_D_1s',	'mRMRMAD_D_10s',	'mRMRMAD_D_50s'};
% list_algos={'mRMR_D_combined', 'mRMR_D_minEnvs_s', 'mRMRV_D_0_25s',	'mRMRV_D_0_5s',	'mRMRV_D_0_75s',	'mRMRV_D_10s',	'mRMRV_D_1s',	'mRMRV_D_50s'};
list_features={'top10', 'top20', 'top30', 'top40', 'top50', 'top60'};

round = 3;

cd(strcat(g_str_pathbase_radar,'/IIITDemo/Arff/BigEnvs/Round',num2str(round)));

folders=dir();
list_folders='';
j=1;
for i=1:length(folders)
    if not(strcmp(folders(i).name,'.'))&&not(strcmp(folders(i).name,'..'))&&not(strcmp(folders(i).name,'.DS_Store'))
        list_folders{j}=folders(i).name;
        j=j+1;
    end
end

% g_str_pathbase_model = 'C:/Users/royd/Box Sync/All_programs_data_IPSN_2016/Simulation/toDhruboMichael/IIITDemo/Models/Roy';

big_results_mean = [];
big_results_median = [];
big_results_mad = [];
big_results_robustscore = [];

for f=1:length(list_features)
    results_per_sheet=[];
    results_mean = [];
    results_median = [];
    results_mad = [];
    results_robustscore = [];
    
    for a=1:length(list_algos)
        result_column=[];
        for d=1:length(list_folders)
            path_train=strcat(g_str_pathbase_radar,'/IIITDemo/Arff/BigEnvs/Round',num2str(round),'/',list_folders{d},'/',list_features{f},'/',list_algos{a});
            path_test=strcat(g_str_pathbase_radar,'/IIITDemo/Arff/BigEnvs/Round',num2str(round),'/',list_folders{d},'/test/',list_features{f},'/',list_algos{a});
            
            [Result]=GenerateCrossEnvironmentResults_HumanOnly_IoTDI(g_str_pathbase_model, path_train, path_test);
            result_column=[result_column;[ Result{:,3} ]'];
        end
        results_per_sheet=[results_per_sheet, result_column];
        
        results_mean = [results_mean, mean(results_per_sheet(:,a))];
        results_median = [results_median, median(results_per_sheet(:,a))];
        results_mad = [results_mad, mad(results_per_sheet(:,a),1)];
        results_robustscore = results_median-results_mad;
    end
    
    big_results_mean = [big_results_mean;results_mean];
    big_results_median = [big_results_median;results_median];
    big_results_mad = [big_results_mad;results_mad];
    big_results_robustscore = [big_results_robustscore;results_robustscore];
    % dlmwrite(strcat(g_str_pathbase_radar,'/IIITDemo/Arff/BigEnvs/Round',num2str(round),'/crossenv_',list_features{f},'_humans.csv'),results_per_sheet);
end

 results_robustscore = results_median-results_mad;

dlmwrite(strcat(g_str_pathbase_radar,'/IIITDemo/Arff/BigEnvs/Round',num2str(round),'/mean_Round',num2str(round),'_humans.csv'),big_results_mean);
dlmwrite(strcat(g_str_pathbase_radar,'/IIITDemo/Arff/BigEnvs/Round',num2str(round),'/median_Round',num2str(round),'_humans.csv'),big_results_median);
dlmwrite(strcat(g_str_pathbase_radar,'/IIITDemo/Arff/BigEnvs/Round',num2str(round),'/mad_Round',num2str(round),'_humans.csv'),big_results_mad);
dlmwrite(strcat(g_str_pathbase_radar,'/IIITDemo/Arff/BigEnvs/Round',num2str(round),'/robustscore_Round',num2str(round),'_humans.csv'),big_results_robustscore);