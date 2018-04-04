function f=activityRegionDiffParameters(Data,windowSize,overlap,Rate,NFFT,thr)
    temp = [];
    for window = windowSize
        for o = overlap
            TimeFreq = spectrogram_nohamming(Data,window,round(o*window),NFFT,Rate);
            P = abs(TimeFreq(:)).^2;
            %power_dbm = 10*log10(abs(power)+eps);
            %{
            [S,F,T,P]=spectrogram(Data,window,round(o*window),NFFT,Rate); 
            F=F-Rate/2;                       
            P=[P(NFFT/2+1:NFFT,:);     
            P(1:NFFT/2,:)];                                                      
            P_dbm=10*log10(abs(P)+eps); 
            thr_dbm = 10*log10(abs(thr)+eps);
            %} 
            power=10*log10(abs(P)+eps);
            for t = thr
                temp = [temp activityRegion(power,t)];
            end
  
        end
    end
    f = temp;
end