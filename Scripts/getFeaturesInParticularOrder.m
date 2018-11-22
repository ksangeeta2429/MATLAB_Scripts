%{
    Call this function from File2Feature.m inside for loop for fft based
    features to store features in an array in a particular order. Helpful
    to compare feature vectors with C# output
%}
function f = getFeaturesInParticularOrder(th,numHitBins_sum,numHitBins_max,numHitBins_median,numHitBins_var,moment_sum,maxFreq,freqWidth,widthLengthRatio1,widthLengthRatio2, totalPowerAboveThr)
    if(th == 2)
        f = totalPowerAboveThr;
    end
    if(th == 4)
        f = numHitBins_var;
    end
    if(th == 14)
        f = numHitBins_var;
    end
    if(th == 16)
        f = maxFreq;
    end
    if(th == 22)
        f = maxFreq;
    end
    if(th == 52)
        f = maxFreq;
    end
    if(th == 76)
        f = widthLengthRatio2;
    end
    if(th == 120)
        f = widthLengthRatio2;
    end
    if(th == 128)
        f = widthLengthRatio2;
    end
    if(th == 148)
        f = widthLengthRatio2;
    end
    if(th == 184)
        f = freqWidth;
    end
    if(th == 198)
        f = numHitBins_median;
    end
end