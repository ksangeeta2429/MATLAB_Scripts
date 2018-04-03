% given the true num and the estimated num
% plot and calculate the statistics of estimation
function plotStat(num_true,num_est)
    figure;plot(num_true,num_est,'.');
    axis([-5 45 -5 50]);
    xlabel('Ground Truth of Number of People','FontSize',18);
    ylabel('Estimated Number of People','FontSize',18);
    set(gca,'FontSize',14);

    corr_coef=corr(num_true,num_est)
    abs_err=abs(num_true-num_est);
    mean_abs_err=mean(abs(num_true-num_est))
    std_abs_err = std(abs(num_true-num_est))
    len = length(num_true)
    hist(abs_err,[0,1,2,3,4,5,6,7,8,9,10])
%     rms_err=(mean((num_true-num_est).^2))^0.5
%     relative_abs_err = sum(abs(num_true-num_est))/sum(abs(num_true-mean(num_true)))
%     root_relative_sqr_err = (sum((num_true-num_est).^2)/sum((num_true-mean(num_true)).^2)).^.5
% 
%     indexNonZero=find(num_true~=0);
%     mean_abs_err_normalize=mean(abs(num_true(indexNonZero)-num_est(indexNonZero))./num_true(indexNonZero))

    mean_abs_err_finegrained=zeros(1,max(num_true)+1);
    rms_err_finegrained=zeros(1,max(num_true)+1);
    for i=0:max(num_true)
        mean_abs_err_finegrained(i+1)=mean(abs(num_true(find(num_true==i))-num_est(find(num_true==i))));
        rms_err_finegrained(i+1)=(mean((num_true(find(num_true==i))-num_est(find(num_true==i))).^2))^0.5;
    end

    %mean_abs_err_finegrained
    %rms_err_finegrained
    figure;plot(0:max(num_true),mean_abs_err_finegrained,'*');
    xlabel('Ground Truth of Number of People','FontSize',18);
    ylabel('Mean Absolute Error','FontSize',18);
    set(gca,'FontSize',14);

%     figure;plot(0:max(num_true),rms_err_finegrained,'*');
%     xlabel('Ground Truth of Number of People','FontSize',14);
%     ylabel('Root Mean Square Error','FontSize',14);





true = num_true;
predict = num_est;
% added 7/21/2014 for candidacy
plot(true,predict,'.');
xlabel('Ground Truth of Number of People','FontSize',18);
ylabel('Mean Absolute Error','FontSize',18);
set(gca,'FontSize',14);
axis([-2,45,-5,50]);
hold on;
plot(true, true,'-');
hold off;
