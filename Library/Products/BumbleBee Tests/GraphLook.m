function GraphLook(Comp, Rate, Title)

N = length(Comp);
lambda = 3e9/5.8e6;

[Time,Unit] = PickTimeScale(N,Rate);
XLable = sprintf('Time in %s', Unit);

%% Graph amplitude
subplot(2,1,1)

plot(Time, abs(Comp))

axis tight
xlabel(XLable)
ylabel('ADC Units')
title(Title);

%% Graph phase
subplot(2,1,2)

if Rate == 250
  RelRange = UnWrap(angle(Comp)/2/pi, -0.5,0.5) * lambda/2;
  plot(Time,RelRange,'r')

else
  NOut = round(N * 250/Rate);
  Ideal = DownSamp(Comp, NOut);
  TimeOut = [0 : NOut - 1] / 250;
  
  RelRange = UnWrap(angle(Ideal)/2/pi, -0.5,0.5) * lambda/2;
  plot(TimeOut,RelRange,'r')
 
end

axis tight
xlabel(XLable)
ylabel('Meters')

title(sprintf('At %d Hz', Rate))