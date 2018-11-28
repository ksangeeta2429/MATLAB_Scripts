% extract noise from a file
% input: a file
% output: mean and std (column vector - on different frequency) of noise in this file

function [m,s]=LocalNoise(fileName,WINDOW,NOVERLAP,secondsPerFrame,NFFT,rate)
%NFFT=256;
sampRate=rate;


data = ReadBin(fileName);
[I,Q,N]=Data2IQ(data);

%   secondsPerFrame=5;
%sampRate=300;
pointsPerFrame=sampRate*secondsPerFrame;
nFrames=floor(N/pointsPerFrame);
overlap=0.5;
nFrames=2*nFrames-1;

if nFrames>0       % at least 1 frame, not too short   
    for k=1:nFrames     
            Iframe=I(1+(k-1)/2*pointsPerFrame:(k+1)/2*pointsPerFrame);
            Qframe=Q(1+(k-1)/2*pointsPerFrame:(k+1)/2*pointsPerFrame);
            stdI(k)=std(Iframe);
    end
else
    error('File too short! cannot get even a single frame to extract noise level');
end

[tmp,k]=min(stdI);  % find the frame with lowest std
Iframe=I(1+(k-1)/2*pointsPerFrame:(k+1)/2*pointsPerFrame);
Qframe=Q(1+(k-1)/2*pointsPerFrame:(k+1)/2*pointsPerFrame);

acI = Iframe - mean(Iframe);
acQ = Qframe - mean(Qframe);
Comp = acI + i*acQ;

%Comp = padSignalWithZeros(Comp,WINDOW,NOVERLAP,NFFT,sampRate);

[S,F,T,P]=spectrogram(Comp,WINDOW,NOVERLAP,NFFT,sampRate,'yaxis');
N
size(P)
Fs=rate;                       
F=F-Fs/2;                       
P=[P(NFFT/2+1:NFFT,:);     
   P(1:NFFT/2,:)]; 
P_dbm=10*log10(abs(P)+eps);

m=mean(P_dbm,2);
s=std(P_dbm,0,2);
%thrPower=mean(P_dbm,2)+3*std(P_dbm,0,2);


% figure;
% plot(F,thrPower);
% figure;
% plot(T,P_dbm(128,:));
% figure;
% hist(P_dbm(128,:),-100:1:100); 

