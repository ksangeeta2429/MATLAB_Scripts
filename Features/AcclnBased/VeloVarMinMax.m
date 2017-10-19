% comp - array of complex humbers, mean subtracted
% Window - window length in seconds
% Overlap - Fractional overlap
% Rate - sampling rate
% Implemented as per VV.docx

function Out = VeloVarMinMax(Data, Window, Overlap, Rate, LowQuant, HighQuant)

%WindowSamples = round(Window*Rate);
%OverlapSamples = round(WindowSamples*Overlap);

WindowSamples = Window;
OverlapSamples = Overlap;


lambda = 3e8/5.8e9;
Range = UnWrap(angle(Data)/2/pi, -0.5, 0.5)* lambda/2;
%Range = UnWrap(angle(Data)/2/pi, -0.5, 0.5)* 2*pi*4096;
%Range = Range * 2.584;
%Range = abs(diff(Range));
%disp(Range(length(Range))-Range(1));
%disp(Range);
%disp(Range(length(Range)));
%disp(sum(Range));
clear('comp');
N = length(Range);

%disp(N);

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
    
    x = [1:length(Feat)];
    %disp(Feat);
    %scatter(x,Feat);
    numFeat = length(Feat);
    Feat = sort(Feat);
    plot(Feat);
    xlabel('Sliding windows');
    ylabel('Max - Min of relative distance for each window');
    % get the difference between the high and low percentiles
    High = round(HighQuant*numFeat);
    Low = max(round(LowQuant*numFeat),1);
    Out = Feat(High) - Feat(Low);
    disp(Out);
end
