for feat=[10 20 30 40 50 60]
    robust_ig=[];
    robust_mrmr=[];
    robust_mad=[];
    
    for e=[2 4 7 8 9]
        robust = dlmread(strcat('C:\Users\royd\Desktop\RobustScores_HumansOnly\robustscore_Round',num2str(e),'_humans.csv'));
        robust_ig=[robust_ig,robust(feat/10,1)];
        robust_mrmr=[robust_mrmr,robust(feat/10,2)];
        robust_mad=[robust_mad,robust(feat/10,10)];
    end
    env=[2 4 7 8 9];
    h = figure;
    plot(env,robust_ig,'g-+');
    hold on
    plot(env,robust_mrmr,'b-*');
    hold on
    plot(env,robust_mad,'r-o');
    legend('InfoGain','mRMR','mRMR\_MAD','Location','southeast');
    saveas(h,strcat('C:\Users\royd\Desktop\figsbyenv_robustness\robustscore_feature',num2str(feat),'_humans.eps'),'eps2c');
end