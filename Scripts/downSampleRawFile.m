%{
    May not handle files other than .bbs and .data
    Written by neel. More general downsampling code can be found in
    ParameterAnalysis and BatchNoiseProd.
    This script takes raw file (.bbs) as input and downsamples it to
    downSampRate.
%}

function downSampleRawFile(file,originalSampRate,downSampRate,outfile)

n = originalSampRate/downSampRate
if(floor(n) == n && n > 1)
    %Read Real and Imaginary part
    [R,I] = ReadRadarReIm(file);
    data = R + i * I;
    data = data(1:n:end);
    WriteBin(outfile,data);
else
    disp('Error : Original Sampling rate should be an integer (>1) multiple of down sampling rate');
end
