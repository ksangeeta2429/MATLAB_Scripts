% comp - array of complex humbers, mean subtracted
% Window - window length in seconds
% Overlap - Fractional overlap
% Rate - sampling rate
% Implemented as per VV.docx

function Out = VeloVarMinMax(Data, Window, Overlap, Rate, LowQuant, HighQuant)

WindowSamples = round(Window*Rate);
OverlapSamples = round(WindowSamples*Overlap);

% lambda = 3e8/5.8e9;
% Range = UnWrap(angle(Data)/2/pi, -0.5, 0.5)* lambda/2;
Range = UnWrap(angle(Data)/2/pi, -0.5, 0.5)* 2*pi*4096;

clear('comp');
N = length(Range);

if (N<WindowSamples)
    Out = max(Range) - min(Range);
else
    k = 1;
    for j = 1:(WindowSamples-OverlapSamples):(N + 1 - WindowSamples)
        startIndex = j; 
        stopIndex = j+WindowSamples-1;
        Feat(k) = max(Range(startIndex:stopIndex)) - min(Range(startIndex:stopIndex));
        k = k + 1;
    end
    
    numFeat = length(Feat);
    Feat = sort(Feat);
    
    % get the difference between the high and low percentiles
    High = round(HighQuant*numFeat);
    Low = max(round(LowQuant*numFeat),1);
    Out = Feat(High) - Feat(Low);
end
