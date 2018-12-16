for i=[2 4 7 8 9]
    robust = dlmread(strcat('C:\Users\royd\Desktop\RobustScores_HumansOnly\robustscore_Round',num2str(i),'_humans.csv'));
    h = figure;
    feat = [10 20 30 40 50 60];
    plot(feat,robust(:,1),'g-+');
    hold on
    plot(feat,robust(:,2),'b-*');
    hold on
    plot(feat,robust(:,10),'r-o');
    legend('InfoGain','mRMR','mRMR\_MAD','Location','southeast');
    saveas(h,strcat('C:\Users\royd\Desktop\figsbytopk_robustness\robustscore_Round',num2str(i),'_humans.eps'),'eps2c');
end

