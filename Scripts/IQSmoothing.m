%IQ smoothing for gradient feature
function d = IQSmoothing(I,Q)

for t=2:length(I)-1
    if abs(I(t)-I(t-1))>400 && abs(I(t)-I(t+1))>400 && abs(I(t-1)-I(t+1))<200
        I(t)=0.5*(I(t-1)+I(t+1));
    end
end

for t=2:length(Q)-1
    if abs(Q(t)-Q(t-1))>400 && abs(Q(t)-Q(t+1))>400 && abs(Q(t-1)-Q(t+1))<200
        Q(t)=0.5*(Q(t-1)+Q(t+1));
    end
end

d = (I-median(I)) + 1i*(Q-median(Q));

end
