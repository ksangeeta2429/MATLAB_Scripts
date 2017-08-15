function Result = RunMean(Data, WindSize)

Assert(mod(WindSize,2) == 1, 'Assumes odd window lenght.')
N = length(Data);
Mid = WindSize/2 + 0.5;

XCorr = xcorr(Data, ones(1,WindSize));
Region = XCorr([1 : N] + N - Mid);

Weight = [...
  [Mid : WindSize], ...
  repmat(WindSize, 1,N - 2*Mid), ...
  [WindSize : -1 : Mid]];

if size(Region,1) == 1
  Result = Region ./ Weight;
else
  Result = Region ./ Weight';
end