% calculate some metrics for the above background region
% AnomImage only tells us which regions are detecting
% out2 is the percent area with hits 
% out1 is the moment, i.e. hits weighted with their frequencies
% based on TFAFS.docx

function [Out1 Out2] = AboveBgndFft(Data, BkData, FftWindow, FftStep, Rate)
%% Calculate Ffts for Noise Data
if isempty(BkData)
    N = length(Data);
    comp = Data;
else
    comp = BkData;
    N = length(BkData);
end

numWindows = floor((N-FftWindow)/FftStep)+1;
nEnergy = double(zeros(numWindows,FftWindow));

for j=1:numWindows
    wStart = (j-1)*FftStep+1;
    wEnd = (j-1)*FftStep + FftWindow;
    
    nEnergy(j,:) = abs(fft(comp(wStart:wEnd)));
end

meanE = zeros(1,FftWindow);
devE = zeros(1,FftWindow);
for j = 1:FftWindow
    meanE(j) = mean(nEnergy(:,j));
    devE(j) = std(nEnergy(:,j));
end

%% Calculate Ffts for Target Data
if isempty(BkData)
    tEnergy = nEnergy;
else
    clear comp;
    comp = Data;
    N = length(Data);
    numWindows = floor((N-FftWindow)/FftStep)+1;
    tEnergy = zeros(numWindows,FftWindow);
    
    for j=1:numWindows
        wStart = (j-1)*FftStep+1;
        wEnd = (j-1)*FftStep + FftWindow;
    
        tEnergy(j,:) = abs(fft(comp(wStart:wEnd)));
    end
end

hits = double(zeros(numWindows,FftWindow));

for j = 1:FftWindow
    hits(:,j) = tEnergy(:,j) > meanE(j) + 3*devE(j);
end

Freq = FftFreq(FftWindow, Rate);

Moment = double(zeros(numWindows,FftWindow));
for j = 1:numWindows
    for k = 1:FftWindow
        Moment(j,k) = hits(j,k) * abs(Freq(k));
    end
end

Out1 = double(sum(Moment(:))) / double(numWindows); % for Moment
Out2 = double(sum(hits(:))) / double((numWindows * FftWindow)); %for percent
   


    



