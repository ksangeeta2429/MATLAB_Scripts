% Input: file name
% Do: draw spectrogram

function plotspect(fileName,WINDOW,NOVERLAP,NFFT,sampRate, plotOffset,PLOTFRAMES)

%OutFile = strcat(fileName,'_spect.emf');
data = ReadBin(fileName);
if PLOTFRAMES==1
    data=data(1+plotOffset:18000+plotOffset); 
end
[I,Q,N]=Data2IQ(data);
%%%%%%%%%%%% figure 1 
%figure;                                        %spectrogram before thresholding
[S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,NFFT,sampRate);


% hist(P_dbm(:),100); %,0:100:10000   [n,xout]=
% thr=median(P_dbm(:))+2*std(P_dbm(:))
% P_dbm_thr=(P_dbm>thr).*P_dbm;
% P_dbm_sum=sum(P_dbm_thr);
% figure;hist(P_dbm_sum(:),0:10:1200);
    

% % filter
% G1 = fspecial('gaussian',[3 3],10);
% G2 = fspecial('gaussian',[3 3],0.1);
% G=G1-G2;
% %G=G1;
% P_dbm = imfilter(P_dbm,G);



% cut the high freq of the spectrogram
bandwidth= 40;
P_dbm=P_dbm(NFFT/2-bandwidth:NFFT/2+1+bandwidth,:);
F=F(NFFT/2-bandwidth:NFFT/2+1+bandwidth);

% to gray scale
P_dbm_gray=mat2gray(P_dbm,[-60 60]);
     
figure;surf(T,F,P_dbm_gray,'EdgeColor','none'); axis tight; view(0,90);axis xy;colormap(jet);caxis([0 1]); 
xlabel('Time (s)','FontSize', 18);
ylabel('Frequency (Hz)','FontSize', 18);
set(gca,'FontSize',14);


% for i=1:size(P_dbm,1)/2   % upside down
%     tmp=P_dbm(i,:);
%     P_dbm(i,:)=P_dbm(size(P_dbm,1)-i,:);
%     P_dbm(size(P_dbm,1)-i,:)=tmp;
% end
% for i=1:size(P_dbm_gray,1)/2
%     tmp=P_dbm_gray(i,:);
%     P_dbm_gray(i,:)=P_dbm_gray(size(P_dbm,1)-i,:);
%     P_dbm_gray(size(P_dbm_gray,1)-i,:)=tmp;
% end


for thr=20:5:50
    bw1=P_dbm>thr;
    figure;imagesc(T,F,bw1);colormap(gray);axis xy; 
    xlabel('Time (s)','FontSize', 18);
    ylabel('Frequency (Hz)','FontSize', 18);
    set(gca,'FontSize',14);
    CC1=bwconncomp(bw1);
    sprintf('Active Region Number is: %d',CC1.NumObjects)
end
bw1=P_dbm>46;
    figure;imagesc(T,F,bw1);colormap(gray);axis xy; 
    xlabel('Time (s)','FontSize', 18);
    ylabel('Frequency (Hz)','FontSize', 18);
    set(gca,'FontSize',14);
    CC1=bwconncomp(bw1);
    sprintf('Active Region Number is: %d',CC1.NumObjects)




for sigma = 3
    for thr= 0.7 %0.4:0.1:0.9
        [imx,imy]=gaussgradient(P_dbm_gray,sigma);
        %mat=(imx.^2+imy.^2).^0.5;     % change to mean square root
        bw=imy>thr;
        for i=1:size(bw,1)
            for j=1:size(bw,2)
                if i<1/5*size(bw,1)
                    bw(i,j)=0;
                end
            end
        end
        figure;imagesc(T,F+5,bw);colormap(gray);axis xy; 
        xlabel('Time (s)','FontSize', 18);
        ylabel('Frequency (Hz)','FontSize', 18);
        set(gca,'FontSize',14);
        CC=bwconncomp(bw);
        sprintf('High Gradient Region Number is:%d',CC.NumObjects)
    end
end






%% filter
% G = fspecial('gaussian',[5 5],10);
% P_dbm = imfilter(P_dbm,G);

% G1 = fspecial('gaussian',[10 10],10);
% G2 = fspecial('gaussian',[10 10],5);
% G=G1-G2;
% P_dbm = imfilter(P_dbm,G);
% figure;imshow(mat2gray(abs(P_dbm)));



%%%%%%%%%%%% figure 2
%figure;
% bar(xout,n/sum(n));                        % histogram of P_dbm after shift 
% axis([-60 80 0 0.01]);
%plot([thr thr],[0 0.01]);

% xlabel('Standardized Energy(dB)','FontSize', 14);
% ylabel('Normalized Probability (Sum to 1)','FontSize', 14);
% title('histogram of P_dbm after shift');
%pause(1);

 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% if ifBackground==0
%     
%     %%%%%%%%%%%% figure 3
%     figure;                                            % bg spectrogram 
%     surf(T,F,P_dbm_bg,'EdgeColor','none'); 
%     caxis([-60 60]); 
%     axis xy; axis tight; colormap(jet); view(0,90);
%     xlabel('Time (s)','FontSize', 14);
%     ylabel('Frequency (Hz)','FontSize', 14);
%     title('bg spectrogram');
%     pause(1);
%     
%     
%     %%%%%%%%%%%% figure 4
%     figure;
%     bar(xout_bg,n_bg/sum(n)); %          % bg histo
%     axis([-60 80 0 0.01]);
%     xlabel('Standardized Energy(dB)','FontSize', 14);
%     ylabel('Normalized Probability (Sum to 1)','FontSize', 14);
%     title('bg histo');
%     pause(1);
%    
%     %%%%%%%%%%%% figure 5
%     figure;                                            % resid spectrogram 
%     surf(T,F,P_dbm_resid,'EdgeColor','none'); 
%     caxis([-60 60]); 
%     axis xy; axis tight; colormap(jet); view(0,90);
%     xlabel('Time (s)','FontSize', 14);
%     ylabel('Frequency (Hz)','FontSize', 14);
%     title('resid spectrogram');
%     pause(1);
%     
%     
%     %%%%%%%%%%%% figure 6 
%     figure;
%     bar(xout,n_resid/sum(n)); %/sum(n)          % resid histo
%     axis([-60 80 -0.01 0.01]);
%     xlabel('Standardized Energy(dB)','FontSize', 14);
%     ylabel('Normalized Probability (Sum to 1)','FontSize', 14);
%     title('resid histo');
%     pause(1);
% end


% figure;plot(1:numOfBins,sum_P_dbm_thr);       % show power
% title('sum_P_dbm_thr');%axis([0,numOfBins,0,1e6]);
% mean(sum_P_dbm_thr)
% figure;plot(1:numOfBins,sum_P_dbm);       % show power
% title('sum_P_dbm');%axis([0,numOfBins,0,1e6]);
% mean(sum_P_dbm)
% figure;plot(1:numOfBins,expectedFreq);   % show expected frequency
% title('expectedFreq');%axis([0,numOfBins,0,30]);
% mean(expectedFreq)


% % % % % 
% % % % % figure;                                                %spectrogram after thresholding
% % % % % surf(T,F,P_dbm_thr+(P_dbm_thr==0).*(ones(size(P))*(-60)),'EdgeColor','none'); 
% % % % % caxis([-60 60]); 
% % % % % axis xy; axis tight; colormap(jet); view(0,90);
% % % % % xlabel('Time');
% % % % % ylabel('Frequency (Hz)');
% % % % % pause(1);


% figure;hist(sum_P_dbm_thr,30);  % show histogram of sum_P_dbm_thr
% title('sum_P_dbm_thr')
% pause(1);


% figure;plot(1:numOfBins,activeFreqWidth); % show activeFreqWidth
% title('activeFreqWidth');%axis([0,numOfBins,0,15]);
% pause(1);

% figure;hist(activeFreqWidth,30);
% title('activeFreqWidth')
% pause(1);

% figure;plot(1:numOfBins,activeFreqDist); % show activeFreqDist
% title('activeFreqDist');%axis([0,numOfBins,0,15]);
% pause(1);

% figure;hist(activeFreqDist,30);
% title('activeFreqDist')



% figure;plot(1:numOfBins,activeFrequencyBandwidth); % show activeFrequencyBandwidth
% axis([0,numOfBins,0,15]);title('activeFrequencyBandwidth');

fclose('all');




