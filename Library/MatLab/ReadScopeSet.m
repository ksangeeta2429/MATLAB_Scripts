function [Time,Volt] = ReadScopeSet(Dir, Chan)

NumChan = length(Chan);

Temp = dir(sprintf('%s/*%s.csv', Dir, Chan{1}));
Chan1NameList = { Temp.name };

NumCap = length(Chan1NameList);

for i = 1 : NumCap
  Temp = Chan1NameList{i};
  Start = strfind(Temp, Chan{1});
  Name = Temp(1 : Start - 1);
  
  for j = 1 : NumChan
    ChanName = strcat(Name, Chan{j});
    [Time{i,j},Volt{i,j}] = Read_DSA7204B(sprintf('%s/%s', Dir,ChanName));
  end
end