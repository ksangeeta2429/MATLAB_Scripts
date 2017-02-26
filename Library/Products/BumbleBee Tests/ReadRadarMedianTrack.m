function Comp = ReadRadarMedianTrack(FileName, Rate, windowSize)

[R,I] = ReadRadarReIm(FileName);

TimeMedianTracking = length(R) / Rate;
windowCount = (TimeMedianTracking(length(TimeMedianTracking))/windowSize);
windowLength = floor(length(R)/windowCount);

for iVar=1:(windowCount)
    medianR = mean(R( (windowLength*(iVar-1)+1) : windowLength*(iVar) ));
    medianI = mean(I( (windowLength*(iVar-1)+1) : windowLength*(iVar) ));

    for j=(windowLength*(iVar-1)+1) : windowLength*(iVar)
        R(j) = R(j) - medianR;
        I(j) = I(j) - medianI;
    end
end

Comp = R + (i * I);