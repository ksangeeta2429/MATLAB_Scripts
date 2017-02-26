function Min = GlobalMin(Data)

Size = size(Data);
NumDim = length(Size);

Min = [];  % Not efficent

for i = 1 : NumDim;
  if Size(i) > 1
    if isempty(Min)
      Min = min(Data);
    else
      Min = min(Min);
    end
  end
end

if isempty(Min)
  Min = Data
end