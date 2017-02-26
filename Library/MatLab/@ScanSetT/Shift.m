function OutObj = Shift(InObj, Shift)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Shift -- Shift each scan in a set of scans by a different amount.

%% Get Key informaiton
NumScan = InObj.NumScan;
NumSamp = InObj.NumSamp;

InData = InObj.Data;

%% Do upsampleing
All = [1 : NumSamp];
for i = 1 : NumScan
  Mask = (1 <= All - Shift(i)) & (All - Shift(i) <= NumSamp);
  
  Overlap = find(Mask);
  OutSide = find(~Mask);
  
  OutData(i,OutSide) = 0;
  OutData(i,Overlap) = ...
    interp1(All,InData(i,:), Overlap - Shift(i), 'spline');
end

%% Fill in structure
This.Data = OutData;
  
This.NumScan = NumScan;
This.NumSamp = NumSamp;
This.NumChan = InObj.NumChan;

%% Return result
OutObj = class(This, 'ScanSetT');