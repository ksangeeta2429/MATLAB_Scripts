function totalPowerAboveThr = TotalPowerAboveThr(Data, FftWindow, FftStep, Rate, thr_sqr_matlab,medianBack,stdBack)
%     [TimeFreq, ~, ~] = spectrogram(Data, FftWindow, FftWindow - FftStep, FftWindow, Rate);
    TimeFreq = spectrogram_nohamming(Data, FftWindow, FftWindow - FftStep, FftWindow, Rate);
    numWindows = size(TimeFreq,2);
    
    x = TimeFreq';
    
%     y = abs(x).^2;   %changed to square in 2/19/15
    
%     plot(y(1,:));
    totalPowerAboveThr = 0;
    for j = 1:FftWindow
%         Out(:,j) =  y(:,j) > thr_matlab(j) ;
        for i=1:numWindows
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
