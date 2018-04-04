function f=highGradientDiffParameters(Data,windowSize,overlap,sigma,Rate,NFFT,thr)
    temp = [];
    Data = padSignalWithZeros(Data,NFFT,0.5*NFFT,NFFT,Rate);
    for window = windowSize
        for o = overlap
           
            TimeFreq = spectrogram_nohamming(Data,window,round(o*window),NFFT,Rate);
            P = abs(TimeFreq(:)).^2;
            %[S,F,T,P]=spectrogram(Data,window,round(o*window),windowSize(length(windowSize)),Rate); 
            %F=F-Rate/2;                       
            %P=[P(NFFT/2+1:NFFT,:);     
            %P(1:NFFT/2,:)];                                                      
            P_dbm=10*log10(abs(P)+eps); 
            %thr_dbm = 10*log10(abs(thr)+eps);
            %power_dbm = 10*log10(abs(power)+eps);
            for s = sigma
                for t = thr
                    temp = [temp highGradient(P_dbm,s,t)];
                end
            end
        end
    end
    f = temp;
end