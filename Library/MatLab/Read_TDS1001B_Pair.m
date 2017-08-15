function [Time,Volt0,Volt1] = Read_TDS1001B_Pair(Path, DirName, DirNum)

FullDir = sprintf('%s/%s%s', Path,DirName,DirNum);
File0 = sprintf('F%sCH1', DirNum);
File1 = sprintf('F%sCH2', DirNum);

[Time0,Volt0] = Read_TDS1001B(sprintf('%s/%s', FullDir,File0));
[Time1,Volt1] = Read_TDS1001B(sprintf('%s/%s', FullDir,File1));

Assert(all(Time0 == Time1));

Time = Time0;
Volt = [Volt0; Volt1];