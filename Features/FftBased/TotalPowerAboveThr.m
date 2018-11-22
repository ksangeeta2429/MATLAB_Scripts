function totalPowerAboveThr = TotalPowerAboveThr(Data, FftWindow, FftStep, Rate, NFFT, thr_sqr_matlab,medianBack,stdBack,TimeFreq)
    %[TimeFreq, ~, ~] = spectrogram(Data, FftWindow, FftWindow - FftStep, FftWindow, Rate);
    
    %compute spectrogram outside the for loop in File2Feature.m, so that it is
    %computed only once
    %TimeFreq = spectrogram_nohamming(Data, FftWindow, FftWindow - FftStep, NFFT, Rate);
    numWindows = size(TimeFreq,2);
    
    x = TimeFreq';
 
%    y = abs(x).^2;   %changed to square in 2/19/15
    
%     plot(y(1,:));
    totalPowerAboveThr = 0;
    l = size(x);
    %for j = 1:FftWindow
    for j = 1:l(2)
%         Out(:,j) =  y(:,j) > thr_matlab(j) ;
        %for i=1:numWindows
        for i = 1:l(1)
            if abs(x(i,j)) > thr_sqr_matlab^0.5
                totalPowerAboveThr = totalPowerAboveThr + abs(x(i,j))^2;
                
%         Out(:,j) =  abs(x(:,j)).^2 > thr_sqr_matlab;
%         Out(:,j) =  abs(x(:,j)) > thr_sqr_matlab^0.5;
% %         Out(:,j) =  abs(x(:,j)) > thr_sqr_matlab^0.5+medianBack(j);
% %         Out(:,j) =  abs(x(:,j)) > medianBack(j)+3*stdBack(j);
            end
        end
    end
end
