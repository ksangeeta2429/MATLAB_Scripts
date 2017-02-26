function snr(File,SampRate)
% Fft_8 -- Call Fft form the DLL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


Fid = fopen(File, 'r');
if (Fid < 0)
  ERROR('Could not open file');
end

Data = fread(Fid, inf, 'int16');

N = length(Data);

if mod(N,2) == 1
  ERROR('Corupted file')
end

I = Data([1 : 2 : N-1]);
Q = Data([2 : 2 : N]);

%M = length(I);
%ChunkI = I;
%ChunkQ = Q;

% Comment the 5 lines above and uncomment the 3 lines below to only use
% certain parts of the data
StartTime = 119;
StopTime = 131;

ChunkI = I([StartTime*SampRate + 1 : StopTime*SampRate]);
ChunkQ = Q([StartTime*SampRate + 1 : StopTime*SampRate]);
M = (StopTime-StartTime)*SampRate;

meanI = mean(ChunkI);
meanQ = mean(ChunkQ);

for i=1:1:M
    Ampl(i) = (ChunkI(i) - meanI)^2 + (ChunkQ(i) - meanQ)^2;
end

Signal = sqrt(mean(Ampl));

fprintf(1,'Signal : %d \n',Signal);
