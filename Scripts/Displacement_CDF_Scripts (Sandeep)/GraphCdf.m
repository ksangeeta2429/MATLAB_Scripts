function GraphCdf(FeatSet,Range, Quant)

[NumRange,NumSamp] = size(FeatSet);

Index = [1 : NumSamp];
QuantIndex = NumSamp*Quant + 0.5;
  
for i = 1 : NumRange
  Cdf = sort(FeatSet(i,:));
  FeatQuant(i,:) = interp1(Index,Cdf, QuantIndex);
end

plot(Range, FeatQuant)

xlabel('Range in Meeters')
ylabel('Feature Value')

for i = 1 : length(Quant)
  Legend{i} = sprintf('%d%%', 100*Quant(i));
end
legend(Legend);