function theophase(Path, File, SampRate, OrigFiltLen)
% Fft_8 -- Call Fft form the DLL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


Fid = fopen(sprintf('%s/%s.data', Path,File), 'r');
if (Fid < 0)
  ERROR('Could not open file');
end

Data = fread(Fid, inf, 'int16');

N = length(Data);
I = Data([1 : 2 : N-1]);
Q = Data([2 : 2 : N]);

j = SampRate;
k = 1;
l = 1;

med = 125;
wphase_prev = 0 ;
uphase_prev = 0;

index = 1;
offset = (SampRate - 1) / 2;
orig_offset = (OrigFiltLen - 1)/2;

while (j < N/2 - SampRate)
    
    NoiseI(k) = sum(I([j-offset:j+offset])) / SampRate;
    NoiseQ(k) = sum(Q([j-offset:j+offset])) / SampRate;
    
    if (k > OrigFiltLen - 1)
        OrigI(l) = sum(NoiseI([l:l+OrigFiltLen-1])) / OrigFiltLen;
        OrigQ(l) = sum(NoiseQ([l:l+OrigFiltLen-1])) / OrigFiltLen;
        
        ResultI(l) = OrigI(l) - NoiseI(k - orig_offset);
        ResultQ(l) = OrigQ(l) - NoiseQ(k - orig_offset);
        
        Comp(l)= ResultI(l) + i*ResultQ(l);
        
        ampl(l) = ResultI(l)*ResultI(l) + ResultQ(l)*ResultQ(l);

        phase(l) = angle(Comp(l));
        
        if (l==1)
            uphase(l) = phase(l);
        else
            phase_diff = phase(l) - wphase_prev;
            if (phase_diff < -pi)
                phase_diff = phase_diff + 2*pi;
            elseif (phase_diff > pi)
                phase_diff = phase_diff - 2*pi;
            end
            uphase(l) = uphase_prev + phase_diff;
        end
        
        wphase_prev = phase(l);
        uphase_prev = uphase(l);
        
        l = l + 1;
    end
        
    j = j + 1;
    k = k + 1;
end

N = length(uphase);
Time = [0:N-1] / SampRate;
plot(Time,uphase);
