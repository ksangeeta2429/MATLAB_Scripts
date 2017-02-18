function Out = MomentMeas(AnomImage, FftFreq)
    [m,n] = size(AnomImage);
    f = abs(FftFreq');
    Out = sum(AnomImage*f) / m;
end

