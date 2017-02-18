function [BackStats] = ComputeBack(compNoise, Window, Overlap)

    comp = compNoise;
    N = length(compNoise);
    numWindows = floor((N-Window)/Overlap);

    nEnergy = double(zeros(numWindows,Window));

    for j=1:numWindows
        wStart = (j-1)*Overlap+1;
        wEnd = (j-1)*Overlap + Window;
    
        nEnergy(j,:) = abs(fft(comp(wStart:wEnd)));
    end

    for j = 1:Window
        meanBack(j) = mean(nEnergy(:,j));
        stdBack(j) = std(nEnergy(:,j));
        medBack(j) = median(nEnergy(:,j));
    end
    
    BackStats = [meanBack,stdBack,medBack];
end

function Out = AnomImage(Data, FftSize, Overlap, MeanBack, DevBack,Mult)

    [TimeFreq, Time, Freq] = spectrogram(Data, FftSize, OverLap*FftSize);

    numWindows = floor((N-Window)/Overlap);
    tEnergy = double(zeros(numWindows,Window));
    
    for j=1:numWindows
        wStart = (j-1)*Overlap+1;
        wEnd = (j-1)*Overlap + Window;
    
        tEnergy(j,:) = abs(fft(comp(wStart:wEnd)));
    end
    
    for j = 1:Window
        Out(:,j) = tEnergy(:,j) > MeanBack(j) + Mult*DevBack(j);
    end
end

function Out = PropMeas(AnomImage)
    Out = sum(AnomImage>1)/FftSize;
end

function Out = MomentMeas(AnomImage, FftFreq)
    Out = sum(AnomImage.*FftFreq) / FftSize;
end

function Out = MaxFeqMeas(AnomImage,FftFreq, Quant, MinAnom)

    for i=1:length(AnomImage,2)
        Index = find(AnomImage(:,i));
        NumHit = length(Index);

        if (NumHit < MinAnom)
            Out(i) = -1;
        else
            [Cdf,Order] = sort(FftFreq(Index));
            Out(i) = interp(FftFreq(Order)/NumHit, Quant);
        end
    end
end

function Out = FreqWidthMeas(AnomImage, FftFreq, M, N)

    for i = 1:length(AnomImage,2)
        NumInWind = sum(AnomImage(1:N,i));
        if (M <= NumInWind) 
            RunLen = N;
        else
            RunLen = 0;
        end
        
        MaxRunLen = RunLen;
        for j = N+1:FftSize
            NumInWind = NumIWind - AnomImage(j,i) + AnomImage(j,i);
            if (M<=NumInWind)
                if (RunLen == 0)
                    RunLen = N;
                else
                    RunLen = RunLen + 1;
                end
            else
                RunLen = 0;
            end;
            
            if (MaxRunLen < RunLen)
                MaxRunLen = RunLen;
            end
        end
        
        Out(i) = MaxRunLen;
    end
end

            
        
