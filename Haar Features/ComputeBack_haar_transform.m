function [avg,stddev]=ComputeBack_haar_transform(Comp,levels)

X=haar_decomp(Comp,levels);
avg=cell(1,size(X,2));
stddev=cell(1,size(X,2));
    for i=1:size(X,2)
        avg{i}=mean(abs(X{i}).^2);
        stddev{i}=std(abs(X{i}).^2);
    end
end