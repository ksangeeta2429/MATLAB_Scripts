
indexFrame = 2; % could be 0, 1, 2, 3......

WINDOW = 256;
NOVERLAP = 256-16;
NFFT = 256;
sampRate = 300;


fileName_I='13Nov_Tom_Radar.dat_I';
fileName_Q='13Nov_Tom_Radar.dat_Q';
fid = fopen(sprintf('C:/Documents and Settings/he/My Documents/Dropbox/MyMatlabWork/radar/STC/data files/tmp/%s',fileName_I), 'r');
I = fread(fid, inf, 'int16');
fclose(fid);

fid = fopen(sprintf('C:/Documents and Settings/he/My Documents/Dropbox/MyMatlabWork/radar/STC/data files/tmp/%s',fileName_Q), 'r');
Q = fread(fid, inf, 'int16');
fclose(fid);

N = length(I);

plotOffset = 18000 * indexFrame;
I=I(1+plotOffset:18000+plotOffset); 
Q=Q(1+plotOffset:18000+plotOffset);


Comp = (I-median(I)) + i*(Q-median(Q));
[S,F,T,P]=spectrogram(Comp,WINDOW,NOVERLAP,NFFT,sampRate);         
                     
F=F-sampRate/2;                       
P=[P(NFFT/2+1:NFFT,:);     
   P(1:NFFT/2,:)];                                                      
P_dbm=10*log10(abs(P)+eps);  



bandwidth=40;
P_dbm=P_dbm(NFFT/2-bandwidth:NFFT/2+1+bandwidth,:);
F=F(NFFT/2-bandwidth:NFFT/2+1+bandwidth);



% to gray scale
P_dbm_gray=mat2gray(P_dbm,[-60 60]);
     
figure;surf(T,F,P_dbm_gray,'EdgeColor','none'); axis tight; view(0,90);axis xy;colormap(jet);caxis([0 1]); 
xlabel('Time (s)','FontSize', 14);
ylabel('Frequency (Hz)','FontSize', 14);