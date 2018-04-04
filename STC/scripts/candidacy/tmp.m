% extract the data from Theo
clear all; close all;
load bestSAXResults
predict=[];
true=[];
for i=1:10
    predict = [predict;bestPredict(i).ymu];
    true = [true;bestPredict(i).T];
end
len=length(true)
mean_abs_err=sum(abs(predict-true))/len;
RMSE = (sum((predict-true).^2)/len).^0.5;
plot(true,predict,'.');
xlabel('Ground Truth of Number of People','FontSize',18);
ylabel('Mean Absolute Error','FontSize',18);
set(gca,'FontSize',14);
axis([-2,45,-5,45]);
hold on;
plot(true, true,'-');
hold off;