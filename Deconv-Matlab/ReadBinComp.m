function [I,Q] = ReadBinComp(FileName)

[RawI,RawQ] = ReadBin(FileName);

DcI = median(RawI);
DcQ = median(RawQ);

I = RawI - DcI;
Q = RawQ - DcQ;