% max frequency of excited region 
% use quantile to discount extreme outliers
function Result = MaxFreqMeas(Img,Freq, Quant, MinAnom)
    
    Out = zeros(1, size(Img,1));
    for i=1:size(Img,1)
        Index = find(Img(i,:));
        NumHit = length(Index);

        if (NumHit <= 1)
            Out(i) = -1;
        else
%             [Cdf,Order] = sort(Freq(Index));
%             Out(i) = interp1(Order/NumHit, Cdf, Quant);
%             Out(i) = max(Freq(Index));  % active point closest to midpoint of the 256 fft output
            Out(i)=max(abs(Freq(Index)));
        end
    end
    
    Result = max(Out);
end




            
        
