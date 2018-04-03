function DataControl(dest,control)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ~libisloaded('sf')
    loadlibrary('sf','MatLab.h')
end

calllib('sf','init',6); %Virutal COM port number for the base station Tmote
pause(0.5);
calllib('sf','writeVals',dest,control);
pause(0.2);
calllib('sf','writeVals',dest,control);
pause(0.2);
calllib('sf','writeVals',dest,control);
pause(0.2);
calllib('sf','close');
pause(0.5);
unloadlibrary 'sf';