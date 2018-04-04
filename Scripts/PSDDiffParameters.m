function f = PSDDiffParameters(Data,window,overlap,Rate,NFFT)
    temp = [];
    Data = padSignalWithZeros(Data,NFFT,0.5*NFFT,NFFT,Rate);
    for w = window
        for o = overlap
            temp = [temp PSD(Data,w,round(o*w),Rate,NFFT)];
        end
    end
    f = temp;
end