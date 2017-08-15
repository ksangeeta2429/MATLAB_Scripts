function UnRots=GetRawUnrots(Comp,SampRate, IQRejectionParam)

%% Subtract DC bias
CompTrim = Comp - MedComp(Comp);

%% Compute noise median
Median = median(abs(CompTrim));

%% Get IQ Rejection threshold
IQRejection = IQRejectionParam*Median;

%% Do Drift
NTrim = length(CompTrim);

if SampRate > 250
  N = length(CompTrim);
  TimeOrigSamp = [0 : N-1] / SampRate;
  TimeReSamp = [0 : 1/250 : NTrim/SampRate];
  CompReSamp = interp1(TimeOrigSamp,CompTrim, TimeReSamp);
else
  TimeReSamp = [0 : NTrim - 1]' / SampRate;
  CompReSamp = CompTrim;
end

%% Do IQ Rejection
CompI = abs(imag(CompReSamp));
CompR = abs(real(CompReSamp));
mask = (CompI < IQRejection) & (CompR < IQRejection);
CompFiltered = CompReSamp;
for i=2:length(CompFiltered)
    if (mask(i))
        CompFiltered(i) = CompFiltered(i-1); 
    end
end

%% Get rots for filtered noise
UnRots = UnWrap(angle(CompFiltered)/2/pi, -0.5, 0.5);