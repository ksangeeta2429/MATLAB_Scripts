function GraphDisp(Time,Comp, Delay,Thresh)

if any(size(Time) ~= size(Comp))
  if lenght(Time) == length(Comp)
    error('Column-vector vs row-vector mismatch')
  else
    error('Input data size mismatch')
  end
end

N = length(Time);
MDelay = length(Delay);

Color = lines(MDelay);

%% Phase unwraping
UnRot = UnWrap(angle(Comp)/2/pi, -0.5, 0.5);

MaxHz = 0;
for Count = 1 : MDelay
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
  plot(MidTime,Hz, 'Color',Color(Count,:))
  hold on
  
  Legend{Count} = sprintf('%.1f s', D);
end

Axis = [Time(1), Time(N), 0, 1.2*MaxHz];
axis(Axis)

MThresh = length(Thresh);
for Count = 1 : length(Thresh)
  Hue = 1/3 * (MThresh - Count)/(MThresh - 1);
  Color = hsv2rgb([Hue 1 1]);
  plot(Axis(1:2), repmat(Thresh(Count),2,1), 'LineWidth',2, 'Color',Color);
end;

hold off

xlabel('Time')
ylabel('Rot/Sec (Hz)')

%legend(Legend);
