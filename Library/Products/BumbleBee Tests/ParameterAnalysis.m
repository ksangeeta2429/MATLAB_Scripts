function CompTrim = ParameterAnalysis(Comp,Rate, Title, Threshold, IQRejection, matches, windowCnt, windowSize)

%% Constants
lambda = 299792458/5.8e9;

%% Graph Amp and pick region
subplot(4,2, [1,2]);

CompTrim = TestNoise(Comp,Rate);
NTrim = length(CompTrim);

title(Title);

%% Do Drift
subplot(4,2, [3,4]);

if Rate > 250
  N = length(CompTrim);
  TimeOrigSamp = [0 : N-1] / Rate;
  TimeReSamp = [0 : 1/250 : NTrim/Rate];
  CompReSamp = interp1(TimeOrigSamp,CompTrim, TimeReSamp);
else
  TimeReSamp = [0 : NTrim - 1]' / Rate;
  CompReSamp = CompTrim;
end

%TestDrift(TimeReSamp,CompReSamp, lambda);
%
GraphDisp(TimeReSamp,CompReSamp, [1],[8 10 12.5]);
title('Displacement')

subplot(4,2, [5,6])

CompI = abs(imag(CompReSamp));
CompR = abs(real(CompReSamp));
mask = (CompI < IQRejection) & (CompR < IQRejection);
CompFiltered = CompReSamp;
for i=2:length(CompFiltered)
    if (mask(i))
        CompFiltered(i) = CompFiltered(i-1); 
    end
end
GraphDisp(TimeReSamp,CompFiltered, [1],[8 10 12.5]);
title(['Displacement with IQ filtering of: ', num2str(IQRejection)])

subplot(4,2, [7,8])

GraphDispDetection(TimeReSamp, CompFiltered, Threshold, IQRejection, matches, windowCnt, windowSize);
