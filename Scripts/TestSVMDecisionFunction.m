% test the svm decision function


j=1;
run=1;
trace=1;
cmdstr = sprintf('svm-predict.exe logs\\features%d_%d_%d.txt human_car_model.txt logs\\human_car_out%d_%d_%d.txt',j,run,trace,j,run,trace);
dos(cmdstr);

f=[10000 1 2 3 4 5];

sv = [
1  1  1 1 1 1;
1  1  2 0 3 2;
-1 -1 1 4 1 1;
-1 1 -1 3 1 3;
];

gamma=0.05;
rho=0;

decision=0;
for i=1:size(sv,1)
    decision = decision + sv(i,1)*exp(-gamma*sum((f(2:size(sv,2))- sv(i,2:size(sv,2))).^2));
end
decision = decision-rho;

class=0;
if (decision>0) class=1;
else class=2;
end

decision
class