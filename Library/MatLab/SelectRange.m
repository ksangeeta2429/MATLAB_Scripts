function [Range,Index] = SelectRange(XAxis)

[Range,Trash] = ginput(2);
%Range(1) = XAxis(1);
%Range(2) = XAxis(length(XAxis));

if isempty(Range)
  Index = [];
else
  Index = find((Range(1) <= XAxis) & (XAxis <= Range(2)));
  
  % Don't know if I should round to the nearest sample or not.
  % But do need to move selections to the end if off the end.
  Range = XAxis(Index([1 length(Index)]));
end