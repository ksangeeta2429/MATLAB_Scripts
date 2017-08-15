function NoiseCdf(File, SampRate, deltaT)

Fid = fopen(sprintf('%s-phase.data', File), 'r');
OutDataFile = strcat(File,sprintf('-cdf-%d.data',deltaT));
if (Fid < 0)
  ERROR('Could not open file');
end

fout = fopen(OutDataFile,'w');

Data = fread(Fid, inf, 'int32');
N = length(Data);

sampWindow = round(deltaT*SampRate);
l = 1;

cumData = zeros(1,N-deltaT*SampRate+1);

while (l < N-sampWindow)
  buffer = Data(l:l+sampWindow-1);
  diff = max(buffer) - min(buffer);
  cumData(l) = diff;      
  l = l + 1;
end
fwrite(fout,cumData,'int16');

plot(cumData);
fclose('all');