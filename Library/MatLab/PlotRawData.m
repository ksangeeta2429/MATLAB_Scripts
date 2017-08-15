function PlotRawData()
% Fft_8 -- Call Fft form the DLL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ~libisloaded('sf')
    loadlibrary('sf','MatLab.h')
end

if ~libisloaded('sf')
    loadlibrary('sf','MatLab.h')
end
calllib('sf','init',3); %Virutal COM port number for the Tmote

SampRate = 167;
PlotWindowSecs = 3;
Width = SampRate*PlotWindowSecs;
Time = [1:Width];
RefreshInterval = 84;

IData = zeros(1,Width);
QData = zeros(1,Width);

readarray = [1:3];
rp = libpointer('int16Ptr',readarray);

plot(Time,IData,'r');
hold on;
plot(Time,QData,'b');
axis([1 Width 0 4200]);
hold off;
pause(0.001);

chI = 0;
chQ = 0;

i = 0;
while (1 > 0)
    calllib('sf','readVals',rp);
    result = get(rp,'Value');

    valid = result(1);
    chI = result(2);
    chQ = result(3);
    
    if (valid==1)
        IData = [chI, IData(1 : Width-1)];
        QData = [chQ, QData(1 : Width-1)];
        i = i + 1;
    end
    
    if (i==RefreshInterval)
        i = 0;
        plot(Time,IData,'r');
        hold on;
        plot(Time,QData,'b');
        axis([1 Width 0 4200]);
        hold off;
        pause(0.005);
    end
end

calllib('sf','close');
unloadlibrary 'sf';
