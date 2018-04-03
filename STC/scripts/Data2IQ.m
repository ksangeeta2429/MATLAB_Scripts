%given a vector data, extract good I Q (smaller than 4096)
function [I,Q,N]=Data2IQ(data)
I = data([1:2:length(data)-1]);
Q = data([2:2:length(data)]);
N = length(I);
for i=1:N         %%%% filtering the raw data   
    if I(i)>4096;
        if i>1 I(i)=I(i-1);
        else I(i)=4096;
        end
            
    end
    if Q(i)>4096;
        if i>1 Q(i)=Q(i-1);
        else I(i)=4096;
        end
    end
end
