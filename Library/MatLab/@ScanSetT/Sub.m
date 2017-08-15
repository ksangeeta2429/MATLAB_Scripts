function NewObj = Diff(Obj, Sub)
%% Median -- Compute the median of a scan set

NumScan = Obj.NumScan;

Data = Obj.Data;
NewData = Data - repmat(Sub, NumScan,1);

NewObj = ScanSetT(NewData);