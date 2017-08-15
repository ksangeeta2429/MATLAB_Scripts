function [Time,Volt] = Read_DSA7204B(Name)

NumHeaderLine = 6;
LeadSkip = 4;
Format = '%f,%f';

[Time,Volt] = ReadTexScope(Name, NumHeaderLine, LeadSkip,Format);