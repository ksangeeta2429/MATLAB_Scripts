        
       
AnomImage=[ 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 1 1 1 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1;
            1 1 1 1 1 0 1 1 1 0 0 0 0 0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 0 0 0 1 1 1 0 1 1 1 1
];
i=1;
        NumInWind = sum(AnomImage(i,1:N))
        if (M <= NumInWind) 
            RunLen = N
        else
            RunLen = 0
        end
        
        MaxRunLen = RunLen;
        for j = N+1:size(AnomImage,2)
            NumInWind = NumInWind - AnomImage(i,j-N) + AnomImage(i,j);
            if (M<=NumInWind)
                if (RunLen == 0)
                    RunLen = N
                else
                    RunLen = RunLen + 1
                end
            else
                RunLen = 0
            end;
            
            if (MaxRunLen < RunLen)
                MaxRunLen = RunLen
            end
        end
        