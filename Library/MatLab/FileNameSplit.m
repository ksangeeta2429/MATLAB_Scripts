function [Dir,Base,Ext] = FileNameSplit(FullName)

NameLen = length(FullName);

SlashPos = findstr(FullName, '\');
if isempty(SlashPos)
  LastSlash = 0;
  Dir = '';
else
  LastSlash = SlashPos(length(SlashPos));
  Dir = FullName(1 : LastSlash - 1);
end

DotPos = findstr(FullName, '.');
if isempty(DotPos)
  LastDot = NameLen + 1;
  Ext = '';
else
  LastDot = DotPos(length(DotPos));
  Ext = FullName(LastDot + 1 : NameLen);
end

Base = FullName(LastSlash + 1 : LastDot - 1);