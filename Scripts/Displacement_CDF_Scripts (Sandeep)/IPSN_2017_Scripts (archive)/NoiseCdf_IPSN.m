function cumData=NoiseCdf_IPSN(Data, name, SampRate, deltaT)

%Fid = fopen(strcat(File,'.data'), 'r');
OutDataFile = strcat('C:\Users\royd\Desktop\IPSN_NoiseData\',name,sprintf('-cdf-%d.data',deltaT));
fout = fopen(OutDataFile,'w');
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

figure;
plot(cumData);
fclose('all');