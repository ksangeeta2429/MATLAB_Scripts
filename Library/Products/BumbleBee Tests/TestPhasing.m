function TestPhasing(Comp)

N = length(Comp);

%% UnWrap
Rot = angle(Comp)/2/pi;

Cdf = sort(Rot);

Temp = ([0 : N-1] + 0.5) / N;
CumProb = Temp;
%if size(Cdf,1) == 1
%  CumProb = Temp;
%else
%  CumProb = Temp';
%end

%% Print graph paper background
CdfErrorGraphPaper;
hold on

%% Graph CdfError
CumProb = CumProb';
CdfError = CumProb - (Cdf + 0.5);

plot(Cdf, CdfError, '.k');
hold off
