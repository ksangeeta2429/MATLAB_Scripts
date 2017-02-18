% find the max continuous freq band that is excited
% Intuition: humans have a smoother motion profile so they will have
% longer continuuous bands 
function Result = FreqWidthMeas(Img, M, N)
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
    
    Result = max(Out);
end
