function [Result1,Result2,Result3] = FreqWidthMeanAndMedian(Img, M, N)
    Out = zeros(1,size(Img,1));
    for i = 1:size(Img,1)
        NumInWind = sum(Img(i,1:N));
        if (M <= NumInWind) 
            RunLen = N;
        else
            RunLen = 0;
        end
        
        MaxRunLen = RunLen;
        for j = N+1:size(Img,2)
            NumInWind = NumInWind - Img(i,j-N) + Img(i,j);
            if (M<=NumInWind)
                if (RunLen == 0)
                    RunLen = N;
                else
                    RunLen = RunLen + 1;
                end
            else
                RunLen = 0;
            end;
            
            if (MaxRunLen < RunLen)
                MaxRunLen = RunLen;
            end
        end
        
        Out(i) = MaxRunLen;
    end
    
    Result1 = mean(Out);
    Result2 = median(Out);
    Result3 = var(Out);
end
