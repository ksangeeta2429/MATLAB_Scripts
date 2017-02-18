%given a vector data, extract good I Q (smaller than 4096)
function [I,Q,N]=Data2IQ(data)
I = data([1:2:length(data)-1]);
Q = data([2:2:length(data)]);
N = length(I);
for i=2:N-1         %%%% filtering the raw data   
    if I(i)>4096 || abs(I(i)-I(i-1))>2000 && abs(I(i)-I(i+1))>1500
        I(i)=I(i-1);
    end
    if Q(i)>4096 || abs(Q(i)-Q(i-1))>2000 && abs(Q(i)-Q(i+1))>1500
        Q(i)=Q(i-1);
    end
end
