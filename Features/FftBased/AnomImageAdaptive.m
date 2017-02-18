function Out = AnomImageAdaptive(Data, FftWindow, FftStep, Rate, factor)
%     factor = 0.5;

%     [TimeFreq, ~, ~] = spectrogram(Data, FftWindow, FftWindow - FftStep, FftWindow, Rate);
    TimeFreq = spectrogram_nohamming(Data, FftWindow, FftWindow - FftStep, FftWindow, Rate);
    numWindows = size(TimeFreq,2);
    
    Out = zeros(numWindows,FftWindow);
    
    x = TimeFreq';
    y = abs(x);
    
    thr = 10^(factor*log10(max(y(:))));
%     plot(y(1,:));

    for j = 1:FftWindow
%         Out(:,j) =  y(:,j) > thr_matlab(j) ;
        Out(:,j) =  y(:,j) > thr ;
    end
end