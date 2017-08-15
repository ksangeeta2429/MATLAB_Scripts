function GraphDisp(Time,Comp, Delay)

N = length(Time);
M = length(Delay);

Color = lines(M);

UnRot = UnWrap(angle(Comp)/2/pi, -0.5, 0.5);

MaxHz = 0;
for Count = 1:M
  D = Delay(Count);
  
  Temp = Time + D;
  Mask = Temp <= Time(N);
  TimeHigh = Temp(find(Mask));
    
  Index = [1 : length(TimeHigh)];
  MidTime = (TimeHigh + Time(Index)) / 2;
  
  UnRotHigh = interp1(Time,UnRot, TimeHigh);
  Disp = UnRotHigh - UnRot(Index);
  Hz = abs(Disp)/D;
  
  MaxHz = max(MaxHz, max(Hz));
  SortHz = sort(Hz);
  

    fitTime = [round(length(Index) * 0.3) : round(length(Index) * 0.6)];
    fitSort = SortHz(fitTime);
    p = polyfit(log(fitTime),log(fitSort),1);
    p2 = exp(polyval(p,log(Index)));
    loglog(MidTime,SortHz, 'Color', Color(Count,:))
    hold on
    loglog(MidTime,p2, 'Color', Color(Count,:))

    Legend{Count} = sprintf('%.1f s', D);
end
hold off

axis([Time(1) Time(N) 0 1.2*MaxHz])

xlabel('Time')
ylabel('Rot/Sec (Hz)')

%legend(Legend);
