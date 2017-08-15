function AmpDetect(File, SampRate, Thresh)

Raw = ReadComp(File)

N = length(I);
detects = zeros(1,N);

medI = median(I);
medQ = median(Q);

for j = 1 : N
  if (((I(j) - medI)^2 + (Q(j) - medQ)^2) > Thresh^2)
    detects(j) = 1;
  end
end

Time = [1:N]/SampRate;
plot(Time,detects);

end