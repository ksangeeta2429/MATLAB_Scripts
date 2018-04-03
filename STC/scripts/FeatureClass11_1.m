%baseline counter

function f=FeatureClass11_1(I, Q)

power=(I-median(I)).^2+(Q-median(Q)).^2;
power_I=(I-median(I)).^2;
power_Q=(Q-median(Q)).^2;

f(1)=sum(power);
f(2)=sum(power_I);
f(3)=sum(power_Q);
f(4)=mean(abs(I-median(I)));
f(5)=mean(abs(Q-median(Q)));
f(6)=var(abs(I-median(I)));
f(7)=var(abs(Q-median(Q)));
