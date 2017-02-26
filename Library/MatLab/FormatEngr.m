function Result = FormatEngr(Num, NumDig)

Suffix = 'yzafpnum kMGTPEZY';

if Num == 0
  Result = '0';
  
else
  FirstDig = floor(log10(Num));
  Group = floor(FirstDig/3);
  GroupDig = 3*Group;

  LastDig = FirstDig - NumDig + 1;
  NumDecimal = GroupDig - LastDig;

  if 0 <= NumDecimal
    FormatStr = sprintf('%%.%df', NumDecimal);
    OutNum = Num/10^GroupDig;
  else
    FormatStr = '%.0f';
    OutNum = round(Num/10^LastDig) * 10^(LastDig - GroupDig);
  end
  Result = sprintf(FormatStr, OutNum);
  
  if Group ~= 0
    Result = sprintf('%s %c', Result, Suffix(Group + 9));
  end

end