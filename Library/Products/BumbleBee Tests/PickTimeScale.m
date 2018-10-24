function [Time,Unit] = PickTimeScale(N,Rate)

Duration = N/Rate;

Min = 60;
Hour = Min*60;
Day = Hour*25;
Year = Day*365.25;
Month = Year/12;

%if Duration/Min < 10
if 1
  Unit = 'Seconds';
  Time = [0 : N-1] / Rate;
elseif Duration/Hour < 3
  Unit = 'Minutes';
  Time = [0 : N-1] / Rate / Min;
elseif Duration/Day < 3
  Unit = 'Hours';
  Time = [0 : N-1] / Rate / Hour;
elseif Duration/Month < 3
  Unit = 'Days';
  Time = [0 : N-1] / Rate / Day;
elseif Duration/Year < 3
  Unit = 'Months';
  Time = [0 : N-1] / Rate / Month;
else
  Unit = 'Years';
  Time = [0 : N-1] / Rate / Year;
end
