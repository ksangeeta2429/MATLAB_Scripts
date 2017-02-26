function OutObj = DownSamp(InObj, SampRatio)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% UpSamp -- Upsample a set of scans

%% Get Key informaiton
NumScan = InObj.NumScan;

InData = InObj.Data;
InNumSamp = InObj.NumSamp;

%% Do upsampleing
for i = 1 : NumScan
  OutData(i,:) = ...
    interp1([1 : InNumSamp],InData(i,:), [1 : SampRatio : InNumSamp], ...
    'spline');
end

%% Fill structure
This.Data = OutData;
  
This.NumScan = NumScan;
This.NumSamp = size(OutData, 2);
This.NumChan = InObj.NumChan;

%% Return result
OutObj = class(This, 'ScanSetT');