function [cumData,OutDataFile]=NoiseCdf_MASS(Data, outPath, outName, SampRate, deltaT, IQRejectionParam)

%Fid = fopen(strcat(File,'.data'), 'r');
if outPath(end) == '/'
    OutDataFile = strcat(outPath,outName,sprintf('-cdf-IQR=%.2f-window=%.2fs.data',IQRejectionParam, deltaT));
else
    OutDataFile = strcat(outPath,'/',outName,sprintf('-cdf-IQR=%.2f-window=%.2fs.data',IQRejectionParam, deltaT));
end

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
fwrite(fout,cumData,'float');

% figure;
% plot(cumData);
fclose('all');