function totalPowerAboveThr = TotalPowerAboveThr(Data, FftWindow, FftStep, Rate, NFFT, thr_sqr_matlab,medianBack,stdBack)
%     [TimeFreq, ~, ~] = spectrogram(Data, FftWindow, FftWindow - FftStep, FftWindow, Rate);
    TimeFreq = spectrogram_nohamming(Data, FftWindow, FftWindow - FftStep, NFFT, Rate);
    numWindows = size(TimeFreq,2);
    
    x = TimeFreq';
   %{ 
    power = [];
    temp = TimeFreq(:,7);
    fd = fopen('power','w');
    for i = 1:length(temp)
        power = [power abs(temp(i))^2]; 
        fprintf(fd,'%f\n',abs(temp(i))^2);
    end
    %}
%     y = abs(x).^2;   %changed to square in 2/19/15
    
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
    %power;
    %for i = 1:30
     %   for j = 1:1
      %     fprintf('%f ',abs(x(j,i)));
       % end
    %end
end
