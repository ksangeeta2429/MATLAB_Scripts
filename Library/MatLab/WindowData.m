function OutData = WindowData(Time,InData, Window)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% WindowData -- Extract the data in a time window

OutData = InData(find((Window(1) <= Time) && (Time <= Window(2))));