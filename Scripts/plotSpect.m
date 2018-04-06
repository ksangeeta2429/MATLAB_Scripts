% Input: file name
% Do: draw spectrogram

% Input: file name
% Do: draw spectrogram

function plotspect(fileName,WINDOW,NOVERLAP,NFFT,sampRate,frameSeconds,plotOffset,PLOTFRAMES,bandwidth)

% OutFile = strcat(fileName,'.spect.emf');
data = ReadBin([fileName,'.data']);
size(data);
%padding zeros, added by neel
X = data;
nx = length(X); %length of cut in number of samples 
number = (nx-NOVERLAP)/(WINDOW-NOVERLAP);
integ = floor(number);
fract = number-integ;
if(nx < WINDOW)
    %Pad the end of X with WINDOW - nx zero's
    X = [X;zeros(WINDOW-nx,1)];
elseif(fract ~= 0)
    temp = nx/(WINDOW-NOVERLAP);
    integer = floor(temp);
    fract = temp - integer;
    del = round((WINDOW-NOVERLAP)*fract);
    if(del < (floor((WINDOW-NOVERLAP) / 2)))
        %delete del number of samples at the end of the cut
        cut_size = length(X);
        X = X(1:cut_size-del);
    else
        %pad the end of X with n_pad_zeros zero's
        temp = floor((nx-NOVERLAP)/(WINDOW-NOVERLAP)) + 1;
        n_pad_zeros = (temp * (WINDOW-NOVERLAP)) - (nx-NOVERLAP);
        X = [X; zeros(n_pad_zeros,1)];
    end
end
nx = length(X);
%end of padding zeros
data = X;
size(data);
if PLOTFRAMES==1
    data=data(1+plotOffset:(2*sampRate*frameSeconds)+plotOffset); 
end
size(data);
[I,Q,N]=Data2IQ(data);

% index=[318*256:327*256]; %51-56
% I=I(index);
% Q=Q(index);

%%%%%%%%%%%% figure 1 
%figure;                                        %spectrogram before thresholding
[S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,NFFT,sampRate);
P_dbm_max = max(P_dbm(:));
grid off;

% tmp = max(P_dbm);
% figure;plot(T,tmp);

% % plot one column in spectrogram
% P = 10.^(P_dbm./10);
% % mean_P_dbm = mean(P_dbm,2);
% % figure;plot(-128:127,mean_P_dbm);axis([-150 150 -30 50])
% % mean_P = mean(10.^(P_dbm./10),2);
% % figure;plot(-128:127,mean_P);
% 
% figure;plot(-128:127,P_dbm(:,16));axis([-150 150 -30 50]);
% figure;plot(-128:127,P(:,16));axis([-150 150 0 200]);


% startingStepIndex = 174*4;
% figure;plot(-128:127,P_dbm(:,startingStepIndex));axis([-150 150 -30 50]);
% figure;plot(-128:127,P_dbm(:,startingStepIndex+1));axis([-150 150 -30 50]);pause
% figure;plot(-128:127,P_dbm(:,startingStepIndex+2));axis([-150 150 -30 50]);pause
% figure;plot(-128:127,P_dbm(:,startingStepIndex+3));axis([-150 150 -30 50]);pause
% figure;plot(-128:127,P_dbm(:,startingStepIndex+4));axis([-150 150 -30 50]);pause
% figure;plot(-128:127,P_dbm(:,startingStepIndex+5));axis([-150 150 -30 50]);pause
% figure;plot(-128:127,P_dbm(:,startingStepIndex+6));axis([-150 150 -30 50]);pause
% figure;plot(-128:127,P_dbm(:,startingStepIndex+7));axis([-150 150 -30 50]);pause
% figure;plot(-128:127,P_dbm(:,startingStepIndex+8));axis([-150 150 -30 50]);pause
% figure;plot(-128:127,P_dbm(:,startingStepIndex+9));axis([-150 150 -30 50]);pause
% figure;plot(-128:127,P_dbm(:,startingStepIndex+10));axis([-150 150 -30 50]);pause
% figure;plot(-128:127,P_dbm(:,startingStepIndex+11));axis([-150 150 -30 50]);pause
% figure;plot(-128:127,P_dbm(:,startingStepIndex+12));axis([-150 150 -30 50]);pause



% cut the high freq of the spectrogram
%bandwidth= 125;
%P_dbm=P_dbm(NFFT/2-bandwidth+1:NFFT/2+bandwidth,:);
%F=F(NFFT/2-bandwidth+1:NFFT/2+bandwidth);


% x = (-127:128)';
% P = 10.^(P_dbm./10);
% y = mean(P_dbm,2);
% figure;plot(x,y);
% 
% [curve, goodness, output]=fit(x,y,'gauss7')
% figure;plot(curve,x,y);



% P_dbm_max = max(P_dbm);
% figure;plot((1:size(P_dbm,2))/4,P_dbm_max);

% y = prctile(P_dbm,95);
% x=(1:size(P_dbm,2))/4;
% figure;plot(x,y);
% 
% res=zeros(6,2);
% res(1,:)=polyfit(x(21.5*4:23.5*4),y(21.5*4:23.5*4),1)
% res(2,:)=polyfit(x(46*4:48*4),y(46*4:48*4),1)
% res(3,:)=polyfit(x(189.75*4:190.5*4),y(189.75*4:190.5*4),1)
% res(4,:)=polyfit(x(215*4:216.25*4),y(215*4:216.25*4),1)
% res(5,:)=polyfit(x(407.75*4:409.5*4),y(407.75*4:409.5*4),1)
% res(6,:)=polyfit(x(437*4:438.5*4),y(437*4:438.5*4),1)
% std(res,1,1)
% to gray scale



P_dbm_gray=mat2gray(P_dbm,[-60 60]);


% for i=1:size(P_dbm_gray,1)
%     for j=1:size(P_dbm_gray,2)
%         if P_dbm_gray(i,j)>0.65
%             P_dbm_gray(i,j)=P_dbm_gray(i,j)-0.05;
%         end
%     end
% end

figure;surf(T,F,P_dbm_gray,'EdgeColor','none'); axis tight; view(0,90);axis xy;colormap(jet);caxis([0 1]); axis tight;
% figure;surf(T,F,P_dbm,'EdgeColor','none'); axis tight; view(0,90);axis xy;colormap(jet);caxis([0 1]); axis tight;

xlabel('Time (s)','FontSize', 20);
ylabel('Frequency (Hz)','FontSize', 20);


% transparent threshold plain

% x1 = [ 0 15 15 0];
% y1 = [ -127 -127 128 128];
% z1 = ones(1,numel(x1))* 0.6; 
% v = patch(x1,y1,z1, 'b');
% set(v,'facealpha',0.6);
% set(v,'edgealpha',0.6);
% set(gcf,'renderer','opengl') ;



%set(gca,'FontSize',40);


% for thr=20:5:35
%     bw1=P_dbm>thr;
%     figure;imagesc(T,F,bw1);colormap(gray);axis xy; 
%     xlabel('Time (s)','FontSize', 18);
%     ylabel('Frequency (Hz)','FontSize', 18);
%     set(gca,'FontSize',14);
%     CC1=bwconncomp(bw1);
%     sprintf('Active Region Number is: %d',CC1.NumObjects)
% end


% for sigma = 3
%     for thr= 0.7 %0.4:0.1:0.9
%         [imx,imy]=gaussgradient(P_dbm_gray,sigma);
%         %mat=(imx.^2+imy.^2).^0.5;     % change to mean square root
%         bw=imy>thr;
%         for i=1:size(bw,1)
%             for j=1:size(bw,2)
%                 if i<1/5*size(bw,1)
%                     bw(i,j)=0;
%                 end
%             end
%         end
%         figure;imagesc(T,F+5,bw);colormap(gray);axis xy; 
%         xlabel('Time (s)','FontSize', 18);
%         ylabel('Frequency (Hz)','FontSize', 18);
%         set(gca,'FontSize',14);
%         CC=bwconncomp(bw);
%         sprintf('High Gradient Region Number is:%d',CC.NumObjects)
%     end
% end






%
% print ('-dmeta', OutFile);
fclose('all');








