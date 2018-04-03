% input:  fIndex, like 294
%         fClass: di ji lei feature
% output: feature value - a scalar
function f=ParamIndex2Feature(fIndex,fClass, I, Q)
NFFT=256;

if fClass==1
    parameterSetting={[32 64 128 256],[1/16 1/8 1/4],[0.95 0.9]};
    n=12;
    [indexes,indexInLoop]=convertIndex(fIndex,parameterSetting,n);
    
    WINDOW = parameterSetting{1}(indexes(1));
    NOVERLAP = WINDOW*(1-parameterSetting{2}(indexes(2)));
    
    dcI = mean(I);   %% mean or median?   ???????
    dcQ = mean(Q);
    acI = I - dcI;
    acQ = Q - dcQ;
    Comp = acI + i*acQ;
    [S,F,T,P]=spectrogram(Comp,WINDOW,NOVERLAP,256,300);   % get P
    Fs=300;                       
    F=F-Fs/2;                       
    P=[P(NFFT/2+1:NFFT,:);     
    P(1:NFFT/2,:)];  

    quan=parameterSetting{3}(indexes(3));
    tmp=FeatureClass1(P,quan);
    f=tmp(indexInLoop); 
end

if fClass==2
    parameterSetting={[32 64 128 256],[1/16 1/8 1/4],[1 2 3 4 5 10 25]};
    n=2;
    [indexes,indexInLoop]=convertIndex(fIndex,parameterSetting,n);
    
    WINDOW = parameterSetting{1}(indexes(1));
    NOVERLAP=WINDOW*(1-parameterSetting{2}(indexes(2)));

    dcI = mean(I);   %% mean or median?   ???????
    dcQ = mean(Q);
    acI = I - dcI;
    acQ = Q - dcQ;
    Comp = acI + i*acQ;
    [S,F,T,P]=spectrogram(Comp,WINDOW,NOVERLAP,256,300);   % get P
    Fs=300;                       
    F=F-Fs/2;                       
    P=[P(NFFT/2+1:NFFT,:);     
       P(1:NFFT/2,:)];  


    lag=parameterSetting{3}(indexes(3));
    tmp=FeatureClass2(P,lag);
    f=tmp(indexInLoop);
end

if fClass==3
    parameterSetting={[32 64 128 256],[1/16 1/8 1/4]};
    n=12;
    [indexes,indexInLoop]=convertIndex(fIndex,parameterSetting,n);
    
    WINDOW = parameterSetting{1}(indexes(1));
    NOVERLAP=WINDOW*(1-parameterSetting{2}(indexes(2)));
    
    dcI = mean(I);   %% mean or median?   ???????
    dcQ = mean(Q);
    acI = I - dcI;
    acQ = Q - dcQ;
    Comp = acI + i*acQ;
    [S,F,T,P]=spectrogram(Comp,WINDOW,NOVERLAP,256,300);   % get P
    numOfBins=length(T);

    Fs=300;                       
    F=F-Fs/2;                       
    P=[P(NFFT/2+1:NFFT,:);     
       P(1:NFFT/2,:)];  
    P_dbm=10*log10(abs(P)+eps);

    sum_P_dbm=sum(P_dbm);
    
    nStd=parameterSetting{3}(indexes(3));        
    thrPower=mean(P_dbm,2)+nStd*std(P_dbm,0,2);        % get thrPower         
    P_dbm_thr=(P_dbm>repmat(thrPower,1,numOfBins)).*P_dbm; 

    sum_P_dbm_thr=sum(P_dbm_thr);
    
    quan=parameterSetting{4}(indexes(4));
    tmp=FeatureClass3(sum_P_dbm,sum_P_dbm_thr,quan);
    f=tmp(indexInLoop);         
end

if fClass==3.1 % to be finished
    parameterSetting={};
    n=5;
    [indexes,indexInLoop]=convertIndex(fIndex,parameterSetting,n);
    
    [S,F,T,P_dbm]=IQ2P_dbm(I,Q,256,256-16,NFFT,sampRate);
    
    sigma=parameterSetting{1}(indexes(1));
    alfa=parameterSetting{2}(indexes(2));
    tmp=FeatureClass3_1(P_dbm);
            
    f=tmp(indexInLoop);
end

if fClass==3.2
    parameterSetting={[0.1 0.2 0.5 1 2 5 10],[0.1 0.2 0.5 0.8 0.9]};
    n=18;
    [indexes,indexInLoop]=convertIndex(fIndex,parameterSetting,n);
    
    [S,F,T,P_dbm]=IQ2P_dbm(I,Q,256,256-16,NFFT,300);
    sigma=parameterSetting{1}(indexes(1));
    alfa=parameterSetting{2}(indexes(2));
    tmp=FeatureClass3_2(P_dbm,sigma,alfa);
            
    f=tmp(indexInLoop);
end
    

if fClass==4
    parameterSetting={[32 64 128 256],[1/16 1/8 1/4],[0 1 2 3 4]};
    n=5;
    [indexes,indexInLoop]=convertIndex(fIndex,parameterSetting,n);
    
    WINDOW = parameterSetting{1}(indexes(1));
    NOVERLAP=WINDOW*(1-parameterSetting{2}(indexes(2)));
    
    dcI = mean(I);   %% mean or median?   ???????
    dcQ = mean(Q);
    acI = I - dcI;
    acQ = Q - dcQ;
    Comp = acI + i*acQ;
    [S,F,T,P]=spectrogram(Comp,WINDOW,NOVERLAP,256,300);   
    Fs=300;                       
    F=F-Fs/2;                       
    P=[P(NFFT/2+1:NFFT,:);                 
       P(1:NFFT/2,:)];  
    P_dbm=10*log10(abs(P)+eps);            % get P_dbm
    [n,xout]=hist(P_dbm(:),-100:0.1:100);  % get n
    
    nStd = parameterSetting{3}(indexes(3));
    hist_thr=median(P_dbm(:))+nStd*std(P_dbm(:));
    tmp=FeatureClass4(P_dbm,n,xout,hist_thr);
    f=tmp(indexInLoop);
end

if fClass==5
    parameterSetting={[32 64 128 256],[1/16 1/8 1/4],[0 1 2 3 4],[0 1 2 3],[0.95,0.9]};
    n=5;
    [indexes,indexInLoop]=convertIndex(fIndex,parameterSetting,n);
    
    WINDOW = parameterSetting{1}(indexes(1));
    NOVERLAP = WINDOW*(1-parameterSetting{2}(indexes(2)));
    
    dcI = mean(I);   %% mean or median?   ???????
    dcQ = mean(Q);
    acI = I - dcI;
    acQ = Q - dcQ;
    Comp = acI + i*acQ;
    [S,F,T,P]=spectrogram(Comp,WINDOW,NOVERLAP,256,300);   % get P
    numOfBins=length(T);

    Fs=300;                       
    F=F-Fs/2;                       
    P=[P(NFFT/2+1:NFFT,:);     
       P(1:NFFT/2,:)];  
    P_dbm=10*log10(abs(P)+eps); 
    
    nStd=parameterSetting{3}(indexes(3));        
    thrPower=mean(P_dbm,2)+nStd*std(P_dbm,0,2);        % get thrPower         
    P_dbm_thr=(P_dbm>repmat(thrPower,1,numOfBins)).*P_dbm; 
    P_dbm_01=(P_dbm_thr~=0);
    
    order=parameterSetting{4}(indexes(4));
    quan=parameterSetting{5}(indexes(5));
    tmp=FeatureClass5(P_dbm_01,F,order,quan);
    f=tmp(indexInLoop);
end

if fClass==6
    parameterSetting={[.01 .025 .05 .1 .2],[10 20 50 100 300 600],[.95 .9]};
    n=6;
    [indexes,indexInLoop]=convertIndex(fIndex,parameterSetting,n);
    
    [Range,Index]=doUnwrap(I,Q,300);
    
    thr = parameterSetting{1}(indexes(1));
    
    span = parameterSetting{2}(indexes(2));
    
    quan = parameterSetting{3}(indexes(3));
    
    tmp=FeatureClass6(Range,thr,span,quan);
    f=tmp(indexInLoop);
end

if fClass==7
    parameterSetting={};
    n=10;
    %[indexes,indexInLoop]=convertIndex(fIndex,parameterSetting,n);
    indexInLoop=fIndex;
    
    tmp=FeatureClass7(I,Q);
    f=tmp(indexInLoop);
end

if fClass== 7.1
    parameterSetting={[0.05,0.1,0.2,0.4,0.5,0.6,0.8,0.9,0.95]};
    n= 4;
    [indexes,indexInLoop]=convertIndex(fIndex,parameterSetting,n);
    
    quan = parameterSetting{1}(indexes(1));
    
    tmp=FeatureClass7_1(I,Q,quan);
    f=tmp(indexInLoop);
end

if fClass== 8.1
    parameterSetting={[200 400 500 600 700 900 1100 1400],[10 20 50 100 300 600 1500],[0.3 0.5 0.7 0.9]};
    n=2;
    [indexes,indexInLoop]=convertIndex(fIndex,parameterSetting,n);
    
    thr=parameterSetting{1}(indexes(1));
    span=parameterSetting{2}(indexes(2));
    thrPercentage=parameterSetting{3}(indexes(3));
    
    tmp=FeatureClass8_1(I,Q,thr,span,thrPercentage);
    f=tmp(indexInLoop);
end

% if fClass== 8.2
%     parameterSetting={xxx};
%     n= xxx;
%     [indexes,indexInLoop]=convertIndex(fIndex,parameterSetting,n);
%     
%     
%     
%     tmp=FeatureClassXXX( , , ,);
%     f=tmp(indexInLoop);
% end

if fClass== 9.1
    parameterSetting={};
    n= 25;
    %[indexes,indexInLoop]=convertIndex(fIndex,parameterSetting,n);
    indexInLoop=fIndex;
    
    
    tmp=FeatureClass9_1(I,Q);
    f=tmp(indexInLoop);
end


%%%%%%%%% Template
% if fClass== xxx
%     parameterSetting={xxx};
%     n= xxx;
%     [indexes,indexInLoop]=convertIndex(fIndex,parameterSetting,n);
%    
%     
%     
%     tmp=FeatureClassXXX(, , ,);
%     f=tmp(indexInLoop);
% end