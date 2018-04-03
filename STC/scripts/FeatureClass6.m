% input a matrix: a time series - Range (phase)
% output a vector: 1 features

function f=FeatureClass6(Range,thr,span,quan)

N= length(Range);
counting=0;  %1 if counting, 0 if not
count=0;     % # of happen
totalTime=0;         % total happening time
for i=1:N-span
    diffRange(i)=Range(i+span)-Range(i);
    if abs(diffRange(i))>=thr       % in time span, the difference of phase is larger than a thr
        if counting==0 
            counting=1;
            count=count+1;
            timerStart=i;
        else % counting==1
                       % counting continue to be 1
        end
        
    else % Range(i+span)-Range(i)<thr
        if counting==0
                       % counting continue to be 0        
        else % counting==1
            counting=0;
            totalTime=totalTime+(i-timerStart);
        end
    end

    if i==N-span && abs(diffRange(i))>thr % 到尾巴了，但结束不了这次的counting
        totalTime=totalTime+(i+1-timerStart);
    end
end
% 每一段结束的时候把totalTime加上,每一段开始的时候数count
f(1)=median(abs(diffRange));
f(2)=var(abs(diffRange));                                                       
f(3)=quantile(abs(diffRange),quan);
f(4)=quantile(abs(diffRange),1-quan);

f(5)=count;
f(6)=totalTime;

