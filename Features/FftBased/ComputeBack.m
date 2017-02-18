% compute mean, std dev and median of background spectral content for noise data
% defined in TFAFS.docx

function [medianBack, stdBack] = ComputeBack(BkData, FftWindow, FftStep)
    comp = BkData;
    N = length(BkData);
    numWindows = floor((N-FftWindow)/FftStep)+1;
    nEnergy = zeros(numWindows,FftWindow);

    for j=1:numWindows
        wStart = (j-1)*FftStep+1;
        wEnd = (j-1)*FftStep + FftWindow;
%         nEnergy(j,:) = abs(fft(comp(wStart:wEnd))).^2;  % .*hamming(FftWindow) added by Jin
        nEnergy(j,:) = abs(fft(comp(wStart:wEnd)));
    end

    
    
    medianBack = zeros(1,FftWindow);
    stdBack = zeros(1,FftWindow);
    for j = 1:FftWindow
        medianBack(j) = median(nEnergy(:,j));
        stdBack(j) = std(nEnergy(:,j));
    end
    
%     figure;plot(-127:128,medianBack');
%     figure;plot(-127:128,stdBack');

%      medianBack = median(nEnergy(:));
%      stdBack = std(nEnergy(:));
end



            
        
