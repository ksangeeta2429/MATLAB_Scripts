function [In, Out, Sig, DeltaR] = RunTest(Amp)

Rate = 44100;
LibFile = 'hostapp';

if ~libisloaded(LibFile)
  loadlibrary(LibFile, 'hostapp_library.h');
end

TempIn = int16(round(GenChirp(1000,4000,1,44100, Amp)));

In = int16(zeros(1,52920));
In(4410:48509) = TempIn;
Out = int16(zeros(1, 52920));

[len, OutIn, Out] = calllib(LibFile,'runCommand', 0, 52920, In, 52920, Out);

In = double(In);
Out = double(Out);

%% Correct for log amplifier
Index = [round(0.1*Rate) : round(1.1*Rate)];
[Sig, DeltaR] = ChirpDelay(In(Index), Out(Index), 1, 3e3, 10);

N = length(Sig);
R = [0 : N-1]*DeltaR;
plot(R, abs(Sig), 'Marker','.')

xlabel('Range in Meters')
ylabel('Magnitude')