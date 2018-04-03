%function PlotRealData()
close all;
w=2;h=3;  

%portNum=4;  %COMx  portNum=x-1;
portNum=2;
if ~libisloaded('TrioSF')
    loadlibrary('TrioSF','MatLab.h')
end
portNum=calllib('TrioSF','init',portNum) %Virutal COM port number for the Tmote, should be 6 for the currently using telosb

%pause(15);

SampRate = 300;
PlotWindowSecs = 30;
Width = SampRate*PlotWindowSecs;
RefreshInterval = 150;
Time=(1:Width)/SampRate;

readarray = [1:4];
rp = libpointer('int16Ptr',readarray);

Range1=0;

predictIntervel = 0;
displayIndex = 0;
saveIndex=0;
saveSpace=3600*SampRate;
dataSaved=zeros(2,saveSpace);
dataDisp = zeros(2,Width);
  
while 1<2
    calllib('TrioSF','readVals',rp);
    result = get(rp,'Value');
    result = double(result);

    valid = result(1);
    cnt = result(2);
    chI = result(3);
    chQ = result(4);
    
    if (valid==1)
        displayIndex = displayIndex + 1;
        saveIndex = saveIndex+1;
        if saveIndex==saveSpace
            'Save space full!'
        end
        
        dataDisp = [[chI;chQ], dataDisp(:,1:Width-1)];
        dataSaved(:,saveIndex)=[chI;chQ];
    end
    
    p=0;
    
    if (displayIndex==RefreshInterval)
        displayIndex = 0;       
        I=dataDisp(1,:);
        Q=dataDisp(2,:);
                               
%% Time Domain
        p=p+1;subplot(w,h,p)
        plot(Time,I,'r');hold on;
        plot(Time,Q,'g');hold off;  
        axis([1 Width/SampRate 0000 5000]);

%% Spectrogram        
        % Compute spectrogram
        [S,F,T,P_dbm]=IQ2P_dbm(I,Q,256,256-32,256,SampRate); %256-16
        P_dbm=mat2gray(P_dbm,[-60 60]);
        % cut the high freq of the spectrogram
        bandwidth=40;
        NFFT=256;
        P_dbm=P_dbm(NFFT/2-bandwidth:NFFT/2+1+bandwidth,:);
        F=F(NFFT/2-bandwidth :NFFT/2+1+bandwidth);
%         % blur gaussian
%         G = fspecial('gaussian',[5 5],2);
%         P_dbm = imfilter(P_dbm,G);
        
        p=p+1;subplot(w,h,p);
        surf(T,F,P_dbm,'EdgeColor','none'); 
        caxis([0 1]); 
        axis xy; axis tight; view(0,90); colormap(jet);        
              
        addpath('gaussgradient');
        [imx,imy]=gaussgradient(P_dbm,5);
        mat1=(imx.^2+imy.^2).^0.5;
        %p=p+1;subplot(w,h,p);imshow(mat1);colormap(jet);axis xy;
        mat2=abs(imx)+abs(imy);
        %p=p+1;subplot(w,h,p);imshow(mat2);colormap(jet);axis xy;
        %imshow(mat,'DisplayRange',[0 1.7],'InitialMagnification','fit');colormap(jet);axis xy; %
        max(abs(imy(:)))
        %p=p+1;subplot(w,h,p);imshow(abs(imy)>0.5);colormap(jet);axis xy;
        p=p+1;subplot(w,h,p);imshow(P_dbm>0.7);colormap(jet);axis xy;
        p=p+1;subplot(w,h,p);imshow(P_dbm>0.9);colormap(jet);axis xy;
        p=p+1;subplot(w,h,p);imshow(abs(imy)>0.9);colormap(jet);axis xy;
%         thr=25;
%         activeFreqWidth=zeros(1,size(P_dbm,2));
%         for j=1:size(P_dbm,2)
%             col=P_dbm(:,j);
%             activeFreqWidth(j)=length(find(col>thr));
%         end
        
        
        %% Phase
        [Range,Index]=doUnwrap(I,Q,SampRate);
        offset=-Range(1+RefreshInterval);  % for plot phase, use this otherwise the plot will always starts from 0

        p=p+1;subplot(w,h,p)
        plot(Time,Range+offset,'b');ylim([-1 1]);
        
%         I = wden(I,'rigrsure','h','sln',3,'sym8');
%         Q = wden(Q,'rigrsure','h','sln',3,'sym8');
%         [S,F,T,P_dbm]=IQ2P_dbm(I,Q,256,256-32,256,SampRate); %256-16
%         P_dbm=mat2gray(P_dbm,[-60 60]);

%        %%  sum_P_dbm  
%         sum_P_dbm = sum(P_dbm);
%         subplot(2,2,3);
%         plot(T,sum_P_dbm,'b');
%         axis([0 Width/SampRate 100 200]);
%         grid on;
        
%         subplot(2,3,4)
%         surf(T,F,P_dbm,'EdgeColor','none'); 
%         caxis([0 1]); 
%         axis xy; axis tight; view(0,90); colormap(jet);
%         
%         subplot(2,3,5)
%         [imx,imy]=gaussgradient(P_dbm,5);
%         mat=abs(imx);%+abs(imy);
%         imshow(mat>0.3);colormap(jet);axis xy;
%         
%        %%  sum_P_dbm  
%         sum_P_dbm = sum(P_dbm);
%         subplot(2,3,6);
%         plot(T,sum_P_dbm,'b');
%         axis([0 Width/SampRate 100 200]);
%         grid on;
        
        
        
%         alfa=0.5;
%         thrx=alfa*3.5;
%         thry=alfa*3.5;
%         thr=alfa*3.5;
%         
%         thrx=2;
% 
%         f=zeros(1,18);
%         f(1)=sum(abs(imx(:)));
%         f(2)=sum(abs(imy(:)));
%         f(3)=sum(mat(:));
%         f(4)=sum(abs(imx(find(abs(imx)>thrx))));    
%         f(5)=sum(abs(imy(find(abs(imy)>thry))));
%         f(6)=sum(mat(find(mat>thr)));
%         f(7)=length(find(abs(imx)>thrx));
%         f(8)=length(find(abs(imy)>thry));
%         f(9)=length(mat(find(mat>thr)));
% 
%         f(10)=max(abs(imx(:)));
%         f(11)=max(abs(imy(:)));
%         f(12)=max(mat(:));
% 
%         f(13)=median(abs(imx(:)));
%         f(14)=median(abs(imy(:)));
%         f(15)=median(mat(:));
% 
%         f(16)=var(abs(imx(:)));
%         f(17)=var(abs(imy(:)));
%         f(18)=var(mat(:));

        %f
        
        
        
        
% filter
%         G1 = fspecial('gaussian',[9 9],2);
%         G2 = fspecial('gaussian',[9 9],10);
%         G=G1-G2;
%         P_dbm_DoG = imfilter(P_dbm,G,'replicate','conv');
        

%         subplot(2,2,4)  
%         G=fspecial('laplacian',0.2);
%         P_dbm_lap = imfilter(P_dbm,G,'replicate','conv');
%         imshow(mat2gray(P_dbm_lap));axis xy; colormap(jet);
                  
        
        
        
%         surf(T,F,P_dbm_DoG,'EdgeColor','none'); 
%         %caxis([-0.04 0.04]); 
%         axis xy; axis tight; view(0,90); colormap(jet);

        
%%  activeFreqWidth
%         p=p+1;subplot(w,h,p)
        
%         plot(Time,Range,'b');%hold on
%         plot(Time,Range,'r');hold off
%         axis([0 Width/SampRate -1 1]);
%         Range1=Range(1); % save for use in next round

%         plot([0,I(1)-2.67e3],[0,Q(1)-2.67e3],'r');
%         axis([-1e3,1e3,-1e3,1e3]);

%         plot(T,activeFreqWidth,'b');
%         axis([0 Width/SampRate 0 50]);




%%
        pause(0.0001);
    end              
    %pause(0.005); %%% 这里千万不能放delay，不然就出现不realtime的情况
end

calllib('TrioSF','close');
unloadlibrary 'TrioSF';

SaveRealData;

