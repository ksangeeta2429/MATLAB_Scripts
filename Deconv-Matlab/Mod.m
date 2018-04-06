function [OutData] = Mod(InData, Shift,OutN)

InN = length(InData);
InTrans = fft(InData);

Mid = floor(InN/2);
if (rem(InN,2) == 1) %% is odd
  OutTrans([0:Shift] + 1) = 0;
  OutTrans([1:Mid] + 1 + Shift) = InTrans([1 : Mid] + 1);
  
  OutTrans([Mid + 1 + Shift : OutN - Mid - 1 - Shift] + 1) = 0;
  
  OutTrans(OutN - [1:Mid] - Shift + 1) = InTrans(InN - [1:Mid] + 1);
  OutTrans(OutN - [1:Shift] + 1) = 0;
  
else %% is even
  OutTrans([0 : Shift] + 1) = 0;
  OutTrans(Shift + [1 : Mid-1] + 1) = InTrans([1 : Mid-1] + 1);
  
  OutTrans(Shift + Mid + 1) = InTrans(Mid + 1) / 2;
  OutTrans([Mid + 1 + Shift : OutN - Mid - 1 - Shift] + 1) = 0;
  OutTrans(OutN - (Mid-1) - Shift) = InTrans(Mid + 1) / 2;
  
  OutTrans(OutN - [1:Mid-1] - Shift + 1) = InTrans(InN - [1:Mid-1] + 1);
  OutTrans(OutN - [1:Shift] + 1) = 0;
    
end

Scale = OutN/InN;
OutData = Scale * real(ifft(OutTrans));