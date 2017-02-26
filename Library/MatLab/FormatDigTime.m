function Result = FormatDigTime(Sec, NumDig)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FormatDigTime -- Formats Digital Time (Y/M/D/H:M:S)

Min = 60;
Hour = 60*Min;
Day = 24*Hour;
Year = 365.25 * Day;
Mon = Year/12;

FormatStr = sprintf('%%.%df', NumDig - 1);

if Sec < Min
  Result = sprintf('% sec', FormatEngr(Sec, NumDig));
elseif Sec < Hour
  Result = sprintf('%s min', sprintf(FormatStr, Sec/Min));
elseif Sec < Day
  Result = sprintf('%s hr', sprintf(FormatStr, Sec/Hour));
elseif Sec < Mon
  Result = sprintf('%s day', sprintf(FormatStr, Sec/Day));
elseif Sec < Year
  Result = sprintf('%s mon', sprintf(FormatStr, Sec/Mon));
else
  Result = sprintf('%s yr', FormatEngr(Sec, NumDig));
end