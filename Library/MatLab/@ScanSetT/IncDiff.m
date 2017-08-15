function NewScanSet = IncDiff(ScanSet)

NumScan = ScanSet.NumScan;
NumSamp = ScanSet.NumSamp;

Data = ScanSet.Data;
Diff = Data(2 : NumScan, :) - Data(1 : NumScan - 1, :);

NewScanSet = ScanSetT(Diff);