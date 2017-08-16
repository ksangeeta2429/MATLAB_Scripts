function [R,I] = ReadRadarReIm(FileName)

Data = ReadRaw(FileName);

[Dir,Base,Ext] = FileNameSplit(FileName);

switch Ext
  case 'bbs'
    [R,I] = SimulToReIm(Data);
  case 'data'
    [R,I] = SimulToReIm(Data);
  case 'bbi'
    [R,I] = InterToReIm(Data);
  case 'bbsu'
    [R,I] = SimulUnToReIm(Data);
  case 'pro'
    cleanData = 0;
    [cleanData, ID, version] = PullCleanData(Data);
    X = ['pulled data from radar ID: ', num2str(ID), ' software version: ', num2str(version)]; disp( X);
    [R,I] = SimulToReIm(cleanData);
  otherwise
    error('Unknown File Type');
end