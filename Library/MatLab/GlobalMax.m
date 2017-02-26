function Max = GlobalMax(Data)

Size = size(Data);
NumDim = length(Size);

Max = [];  % Not efficent

for i = 1 : NumDim;
  if Size(i) > 1
    if isempty(Max)
      Max = max(Data);
    else
      Max = max(Max);
    end
  end
end

if isempty(Max)
  Max = Data
end