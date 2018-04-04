% Data - array of Datalex numbers, mean subtracted
% PTile - which percentile (number from 1-100)
% Window - window length in seconds
% Overlap - Fractional overlap
% Rate - sampling rate
% Implemented according to the writeup in MV.docx

function Out = ApproxMax(Data, VelWindow, VelOverlap, Rate, quantile)

%WindowSamples = round(VelWindow*Rate);
%OverlapSamples = round(VelOverlap*WindowSamples);

WindowSamples = VelWindow;
OverlapSamples = VelOverlap;

% convert data into range (in meters)
% lambda = 3e8/5.8e9;
% Range = UnWrap(angle(Data)/2/pi, -0.5, 0.5)* lambda/2;
Range = UnWrap(angle(Data)/2/pi, -0.5, 0.5)* 2*pi*4096;


N = length(Range);

k = 1;
% calculate for each window with specified overlap
for j = 1:(WindowSamples-OverlapSamples):(N + 1 - WindowSamples)
    Fit = polyfit(0:WindowSamples-1,Range(j:j+WindowSamples-1)',1);
    Velo(k) = abs(Fit(1));
    k = k + 1;
end

Velo = sort(Velo);
Out = Velo(ceil(quantile*length(Velo)));