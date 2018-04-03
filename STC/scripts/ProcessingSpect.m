% input: I Q
% output: spectrogram related properties


function [T F P sum_P_dbm sum_P_dbm_thr P_dbm P_dbm_thr numOfBins ...
 expectedFreq activeFreqWidth activeFreqDist everActiveFreqWidth ...
 xout n xout_rightmost max_n xout_peak ... 
 ] = ProcessingSpect(I, Q, WINDOW,NOVERLAP,NFFT,sampRate, thrPower);

%I Q

%




%thr=23;
%%%%%%%%%%%%%%%%%%%%%%%%% load  background %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% if ifBackground==0
%     file_bg=strcat('bg_',num2str(roomInFilename));
%     if ~exist(strcat(file_bg,'.mat'),'file')
%         file_bg='bg_266';
%     end
%     load(file_bg, 'xout_bg', 'n_bg', 'P_dbm_bg')
% else
%     xout_bg=0;
%     n_bg=0;
%     P_dbm_bg=0;
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Time domain processing %%%%%%%%%%%%%%%%%%%%%
dcI = mean(I);   %% mean or median?   ???????
dcQ = mean(Q);
acI = I - dcI;
acQ = Q - dcQ;
Comp = acI + i*acQ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%% spectrogram preprocessing %%%%%%%%%%%%%%%%%%%%
[S,F,T,P]=spectrogram(Comp,WINDOW,NOVERLAP,NFFT,sampRate,'yaxis');         
numOfBins=length(T);

%%%%%%%%% convert to negative frequency
Fs=300;                       
F=F-Fs/2;                       
P=[P(NFFT/2+1:NFFT,:);     
   P(1:NFFT/2,:)];                                                         %%%%% compute P
                                                        
P_dbm=10*log10(abs(P)+eps);  
[n,xout]=hist(P_dbm(:),-100:0.1:100);                                      %%%%% compute n

[max_n,index]=max(n);
xout_peak=xout(index);


% if ifShiftHist==1
%     xout=xout-xout_peak;              %%%shift hist to left
% else
%     thr=thr+xout_peak;
% end
% 
% if ifShiftSpect==1
%     P_dbm=P_dbm-xout_peak;          %%%%% shift spec to have few red points                      %%%% this step is very suspecious???
% end

n=n(find(abs(xout+75)<0.01):find(abs(xout-75)<0.01));
xout=-75:0.1:75;          %%%%  make xout be synmetric                     %%%%% compute xout


% if ifBackground==0
%     n_resid=n-n_bg;
% 
%     n_resid_tail=n_resid(find(abs(xout-thr)<0.01):max(find(n_resid~=0)));
%     %xout_tail=xout(find(abs(xout-thr)<0.01):max(find(n_resid~=0)));   
%     
%     P_dbm_resid=P_dbm-mean(P_dbm_bg,2)*ones(1,numOfBins);
% else
%     n_resid=0;
%     n_resid_tail=0;
%     P_dbm_resid=0;
% end




%P_dbm=P_dbm_resid;        % denoise



% P_dbm(55:70,:)=1/3*P_dbm(55:70,:); % suppress the noise band at 80Hz by db 
P_dbm_thr=(P_dbm>repmat(thrPower,1,numOfBins)).*P_dbm;                                          %%%%% compute P_dbm_thr
% P_dbm(55:70,:)=3*P_dbm(55:70,:); % recover the noise band at 80Hz by db    %%%%% compute P_dbm


%%%%%%%%%%%%%%%%%%%%%%%%%%%% spectrogram processing %%%%%%%%%%%%%%%%%%%%%%%
%mean_P_dbm=mean(P_dbm(:));
P_dbm_thr=zeros(size(P_dbm));
everActiveFreq=zeros(1,NFFT);
for j=1:numOfBins
    expectedFreq(j)=sum([(NFFT/2-1):-1:0 1:NFFT/2].*P_dbm(:,j)')/sum(P_dbm(:,j));
    sum_P_dbm(j)=sum(P_dbm(:,j));
    sum_P_dbm_thr(j)=sum(P_dbm_thr(:,j));
    clear activeFreq;
    activeFreq=find(P_dbm_thr(:,j)~=0);
    activeFreqWidth(j)=length(activeFreq);
    if length(activeFreq)>=2
        activeFreqDist(j)=max(activeFreq)-min(activeFreq);
    else activeFreqDist(j)=0;   % 1 number or 0 number don't have the dist between max and min
    end
    
    clear tmp;
    tmp=zeros(1,NFFT);
    tmp(activeFreq)=1;
    everActiveFreq=everActiveFreq | tmp;    % ever active frequency
end
everActiveFreqWidth=sum(everActiveFreq);         % 1+1+1+1.....  is the num of 1 s in the vector [0 0 0 1 1 0 1 0 0 0 ...]

%%%%%%%%%%%%%%%%%%%%%%%%%%%% histogram processing %%%%%%%%%%%%%%%%%%%%%%%%%
xout_rightmost=xout(max(find(n~=0)));

% height=n(find(abs(xout-thr)<0.01));   % height of vertical threshold line in the histogram
% area_hist=sum(n(find(abs(xout-thr)<0.01):max(find(n~=0))));



% if ifBackground==0
% 
%     area_tail=sum(n_resid_tail);
%     length_tail=length(n_resid_tail);
%     if length_tail==0
%         height_tail=0;
%     else
%         height_tail=max(n_resid_tail);
%     end
%     ratio_tail=height_tail/length_tail;
% else
%     area_tail=0;
%     length_tail=0;
%     height_tail=0;
%     ratio_tail=0;
% end

%area_hist_abn=sum(n_abn(find(abs(xout-thr)<0.01):max(find(n_abn~=0))));                             % abnormal shape (with tail)
%area_hist_abn1=sum(n_abn(min(find(n_abn>n_thr && min(find(n_abn)))):max(find(n_abn~=0))))
%max(xout(n>max_n*0.1))

%%%%%%%%%%%%%%%%%%%%%%%%% save  background %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% if ifBackground==1
%     xout_bg=xout;
%     n_bg=n;
%     P_dbm_bg=P_dbm;
%     file_bg=strcat('bg_',num2str(roomInFilename));
% %    save(file_bg, 'xout_bg', 'n_bg', 'P_dbm_bg')
% end







