function Result = Median(Obj)
%% Median -- Compute the median of a scan set

Data = Obj.Data;
Result = median(Data,1);