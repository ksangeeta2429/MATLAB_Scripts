function [Time,Volt] = ReadTexScope...
  (Name, NumHeadLine, LeadSkip, Format)

if isempty(regexp(Name, '.csv','end'))
  FullName = sprintf('%s.csv', Name);
else
  FullName = Name;
end

Fid = fopen(FullName, 'r');

if Fid < 0
  error('Could not open file')
else
  for i = 1 : NumHeadLine
    Trash = fgetl(Fid);
  end

  Len = 0;
  Line = fgetl(Fid);

  while (0 < Line(1))
    Len = Len + 1;
    N = length(Line);
  
    Values = sscanf(Line(LeadSkip:N), Format);
    Time(Len) = Values(1);
    Volt(Len) = Values(2);
  
    Line = fgetl(Fid);
  end

  fclose(Fid);
end