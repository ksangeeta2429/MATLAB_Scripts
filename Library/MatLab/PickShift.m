function Shift = PickShift(Time0,Data0, Time1,Data1)

plot(Time0,Data0,'b');
Point0 = ginput(1);

plot(Time1,Data1,'r');
Point1 = ginput(1);

Shift = Point1(1) - Point0(1);
plot(Time0,Data0,'r', Time1 - Shift,Data1,'b');