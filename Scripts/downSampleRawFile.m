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
    %[R,I] = ReadRadarReIm(file);
    %data = R + i * I;
    
    %Read I Q I Q I Q ....
    data_seq = ReadRaw(file);
    R = data_seq(1:2:end);
    I = data_seq(2:2:end);
    data = R + i * I;
    data = data(1:n:end);
    dummy = data(1:20);
    size(data);
    %[I,Q,N] = Data2IQ(data);
    %size(I);
    d = [];
    dummy2 = dummy(1);
    real(dummy2)
    imag(dummy2)
    for j = 1:length(data)
        d = [d real(data(j)) imag(data(j))];
    end
    %d = zeros(1,2*N);
    d(1:20)
    size(d)
    %d(1:2:end) = I;
    %d(2:2:end) = Q;
    WriteRaw(outfile,d,'uint16');
    %fd = fopen(outfile,'w');
    %for i = d
        %fprintf(fd,''
   % end
else
    disp('Error : Original Sampling rate should be an integer (>1) multiple of down sampling rate');
end
