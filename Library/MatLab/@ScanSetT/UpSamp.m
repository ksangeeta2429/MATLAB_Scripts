function OutObj = UpSamp(InObj, SampRatio)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% UpSamp -- Upsample a set of scans

%% Get Key informaiton
NumScan = InObj.NumScan;

InData = InObj.Data;
InNumSamp = InObj.NumSamp;
OutNumSamp = round(InNumSamp * SampRatio);

%% Do upsampleing
for i = 1 : NumScan
  OutData(i,:) = UpSamp(InData(i,:), OutNumSamp);
end

%% Fill structure
This.Data = OutData;
  
This.NumScan = NumScan;
This.NumSamp = OutNumSamp;
This.NumChan = InObj.NumChan;

%% Return result
OutObj = class(This, 'ScanSetT');