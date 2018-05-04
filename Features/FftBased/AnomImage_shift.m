% given a dataset, compare which regions in the spectrogram are more than
% mult*StdDev apart from the mean for the no target case
% MeanBack, DevBack are the median and Std Dev for the background noise
% mult is how many std devs above/below median (typically 3 works best)
% based on TFAFS.docx

function Out = AnomImage_shift(Data, FftWindow, FftStep, Rate, NFFT, thr_sqr_matlab,medianBack,stdBack)
%     [TimeFreq, ~, ~] = spectrogram(Data, FftWindow, FftWindow - FftStep, FftWindow, Rate);
    [TimeFreq,TimeFreq_shift] = spectrogram_nohamming(Data, FftWindow, FftWindow - FftStep, NFFT, Rate);
    numWindows = size(TimeFreq,2);
    
    Out = zeros(numWindows,FftWindow);
    
    x = TimeFreq_shift';

%     y = abs(x).^2;   %changed to square in 2/19/15
    
%     plot(y(1,:));

    l = size(x);
    %for j = 1:FftWindow
    for j = 1:l(2)
%         Out(:,j) =  y(:,j) > thr_matlab(j) ;
        

        %Out(:,j) =  10*log10(abs(x(:,j)).^2+eps) > thr_sqr_matlab;
        Out(:,j) =  abs(x(:,j)) > thr_sqr_matlab^0.5;
%         Out(:,j) =  abs(x(:,j)) > thr_sqr_matlab^0.5+medianBack(j);
%         Out(:,j) =  abs(x(:,j)) > medianBack(j)+3*stdBack(j);
    end  
    Out;
end




            
        




            
        
