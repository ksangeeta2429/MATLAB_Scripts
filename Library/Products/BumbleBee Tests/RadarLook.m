function MadeFig = RadarLook(FileName, Rate)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  RadarLook -- Quick check of a radar file to see if it's OK

lambda = 3e8/5.8e9;

Comp = ReadRadar(FileName);

[Dir,BaseName,Ext] = FileNameSplit(FileName);
Title = sprintf('%s.%s', BaseName,Ext);

GraphLook(Comp,Rate, Title);

MadeFig = true;