function DoAmp(File, StopDist)

Path = 'Data/0-Amplitude';
Comp = ReadComp(sprintf('%s/%s', Path,File));

disp(sprintf('Selted the walkin that stops at %d m',StopDist));
FitAmp(Comp, StopDist, 25,50);