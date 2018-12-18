function [numHitBins_sum, numHitBins_max, moment_sum, numHitBins_median,numHitBins_var] = SpectStat(Img, Freq)
    numHitBins = sum(Img,2);
    numHitBins_sum = sum(numHitBins);    % need normalization after put displacement detection
    numHitBins_max = max(numHitBins);
    
%     numHitBins_median = median(numHitBins(numHitBins>0));
    numHitBins_median = median(numHitBins);
    
    
    %numHitBins_mean = numHitBins_sum/size(Img,1);
    
    numHitBins_var = var(numHitBins);
    
    moment = Img*abs(Freq');
    moment_sum = sum(moment);
	%moment_mean = moment_sum/size(Img,1);
    
%     moment_var = var(moment);

%debug
% numHitBins_hengguolai = numHitBins'

end

