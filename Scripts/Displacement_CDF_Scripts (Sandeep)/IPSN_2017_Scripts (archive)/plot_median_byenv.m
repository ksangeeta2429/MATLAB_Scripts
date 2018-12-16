for feat=[10 20 30 40 50 60]
    median_ig=[];
    median_mrmr=[];
    median_mad=[];
    
    for e=[2 4 7 8 9]
        median = dlmread(strcat('C:\Users\royd\Desktop\Median_Humans\median_Round',num2str(e),'_humans.csv'));
        median_ig=[median_ig,median(feat/10,1)];
        median_mrmr=[median_mrmr,median(feat/10,2)];
        median_mad=[median_mad,median(feat/10,10)];
    end
    env=[2 4 7 8 9];
    h = figure;
    plot(env,median_ig,'g-+');
    hold on
    plot(env,median_mrmr,'b-*');
    hold on
    plot(env,median_mad,'r-o');
    legend('InfoGain','mRMR','mRMR\_MAD','Location','southeast');
    saveas(h,strcat('C:\Users\royd\Desktop\figsbyenv_median\median_feature',num2str(feat),'_humans.eps'),'eps2c');
end