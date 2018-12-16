function [cumData,OutDataFile]=NoiseCdf_MASS(Data, outPath, outName, SampRate, deltaT, IQRejectionParam,N)

%Fid = fopen(strcat(File,'.data'), 'r');
if outPath(end) == '/'
    OutDataFile = strcat(outPath,outName,sprintf('-cdf-IQR=%.2f-window=%.2fs.data',IQRejectionParam, deltaT));
else
    OutDataFile = strcat(outPath,'/',outName,sprintf('-cdf-IQR=%.2f-window=%.2fs.data',IQRejectionParam, deltaT));
end

fout = fopen(OutDataFile,'w');
NumSamples = length(Data);

sampWindow = round(deltaT*SampRate*N);
l = 1;

%cumData = zeros(1,NumSamples-sampWindow+1);



while (l < NumSamples-sampWindow)
  buffer = Data(l:l+sampWindow-1);
  diff = max(buffer) - min(buffer);
  cumData(l) = diff;      
  l = l + 1;
end
fwrite(fout,cumData,'float');

% figure;
% plot(cumData);
fclose('all');