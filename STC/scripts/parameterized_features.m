% create lots of features only differ on the parameter setting
% input: all
% output:f (feature vector)
function f=parameterized_features(I, Q, fClass,WINDOW,NFFT,rate)

sampRate=rate;
%NFFT=nextpow2(rate);
f=[];

% Class 1
if fClass==1
    parameterSetting={[32 64 128 256],[1/16 1/8 1/4],[0.95 0.9]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    for i1=1:nValue(1)
        WINDOW = parameterSetting{1}(i1);
        for i2=1:nValue(2)
            NOVERLAP = WINDOW*(1-parameterSetting{2}(i2));

            Comp=(I-median(I))+i*(Q-median(Q));
            [S,F,T,P]=spectrogram(Comp,WINDOW,NOVERLAP,256,300);   % get P
            Fs=300;                       
            F=F-Fs/2;                       
            P=[P(NFFT/2+1:NFFT,:);     
            P(1:NFFT/2,:)];  

            for i3=1:nValue(3)
                quan=parameterSetting{3}(i3);
                f=[f,FeatureClass1(P,quan)];
            end
        end
    end
end

% Class 2
if fClass==2
    parameterSetting={[32 64 128 256],[1/16 1/8 1/4],[1 2 3 4 5 10 25]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    for i1=1:nValue(1)
        WINDOW =parameterSetting{1}(i1);
        for i2=1:nValue(2)
            NOVERLAP=WINDOW*(1-parameterSetting{2}(i2));

            Comp=(I-median(I))+i*(Q-median(Q));
            [S,F,T,P]=spectrogram(Comp,WINDOW,NOVERLAP,256,300);   % get P
            Fs=300;                       
            F=F-150;                       
            P=[P(NFFT/2+1:NFFT,:);     
               P(1:NFFT/2,:)];  

            for i3=1:nValue(3)
                lag=parameterSetting{3}(i3);
                f=[f,FeatureClass2(P,lag)];
            end
        end
    end
end

% Class 3
if fClass==3
    parameterSetting={[32 64 128 256],[1/16 1/8 1/4]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    for i1=1:nValue(1)
        WINDOW = parameterSetting{1}(i1);
        for i2=1:nValue(2)
            NOVERLAP=WINDOW*(1-parameterSetting{2}(i2));
            [S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,NFFT,sampRate);
            numOfBins=length(T);
            sum_P_dbm=sum(P_dbm);

%             for i3=1:nValue(3)
%                 nStd=parameterSetting{3}(i3);        
%                 thrPower=mean(P_dbm,2)+nStd*std(P_dbm,0,2);        % get thrPower         
%                 P_dbm_thr=(P_dbm>repmat(thrPower,1,numOfBins)).*P_dbm; 

                %sum_P_dbm_thr=sum(P_dbm_thr);
             f=[f,FeatureClass3(P_dbm, S);];
%             end
        end
    end
end

if fClass==3.1
    [S,F,T,P_dbm]=IQ2P_dbm(I,Q,256,256-16,NFFT,sampRate);
    f=FeatureClass3_1(P_dbm);
end

if fClass==3.2
    [S,F,T,P_dbm]=IQ2P_dbm(I,Q,256,256-16,NFFT,sampRate);
    parameterSetting={[0.1 0.2 0.5 1 2 5 10],[0.1 0.3 0.5 0.7 0.9]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    for i1=1:nValue(1)
        sigma=parameterSetting{1}(i1);
        for i2=1:nValue(2)
            thr=parameterSetting{2}(i2);
            f=[f,FeatureClass3_2(P_dbm,sigma,thr)];
        end
    end
end

if fClass==3.4
    [S,F,T,P_dbm]=IQ2P_dbm(I,Q,256,256-16,NFFT,sampRate);
    parameterSetting={[0.1 0.2 0.5 1 2 5 10],[0.1 0.3 0.5 0.7 0.9]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    for i1=1:nValue(1)
        sigma=parameterSetting{1}(i1);
        for i2=1:nValue(2)
            thr=parameterSetting{2}(i2);
            f=[f,FeatureClass3_4(P_dbm,sigma,thr)];
        end
    end
end
if fClass==3.41
    [S,F,T,P_dbm]=IQ2P_dbm(I,Q,256,256-16,NFFT,sampRate);
    parameterSetting={[0.1],[0.1 0.3 0.5 0.7 0.9]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    for i1=1:nValue(1)
        sigma=parameterSetting{1}(i1);
        for i2=1:nValue(2)
            thr=parameterSetting{2}(i2);
            f=[f,FeatureClass3_4(P_dbm,sigma,thr)];
        end
    end
end
if fClass==3.42
    [S,F,T,P_dbm]=IQ2P_dbm(I,Q,256,256-16,NFFT,sampRate);
    parameterSetting={[1],[0.1 0.3 0.5 0.7 0.9]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    for i1=1:nValue(1)
        sigma=parameterSetting{1}(i1);
        for i2=1:nValue(2)
            thr=parameterSetting{2}(i2);
            f=[f,FeatureClass3_4(P_dbm,sigma,thr)];
        end
    end
end
if fClass==3.43
    [S,F,T,P_dbm]=IQ2P_dbm(I,Q,256,256-16,NFFT,sampRate);
    parameterSetting={[10],[0.1 0.3 0.5 0.7 0.9]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    for i1=1:nValue(1)
        sigma=parameterSetting{1}(i1);
        for i2=1:nValue(2)
            thr=parameterSetting{2}(i2);
            f=[f,FeatureClass3_4(P_dbm,sigma,thr)];
        end
    end
end
if fClass==3.44
    [S,F,T,P_dbm]=IQ2P_dbm(I,Q,256,256-16,NFFT,sampRate);
    parameterSetting={[0.1 0.2 0.5 1 2 5 10],[0.1]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    for i1=1:nValue(1)
        sigma=parameterSetting{1}(i1);
        for i2=1:nValue(2)
            thr=parameterSetting{2}(i2);
            f=[f,FeatureClass3_4(P_dbm,sigma,thr)];
        end
    end
end
if fClass==3.45
    [S,F,T,P_dbm]=IQ2P_dbm(I,Q,256,256-16,NFFT,sampRate);
    parameterSetting={[0.1 0.2 0.5 1 2 5 10],[0.5]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    for i1=1:nValue(1)
        sigma=parameterSetting{1}(i1);
        for i2=1:nValue(2)
            thr=parameterSetting{2}(i2);
            f=[f,FeatureClass3_4(P_dbm,sigma,thr)];
        end
    end
end
if fClass==3.46
    [S,F,T,P_dbm]=IQ2P_dbm(I,Q,256,256-16,NFFT,sampRate);
    parameterSetting={[0.1 0.2 0.5 1 2 5 10],[0.7]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    for i1=1:nValue(1)
        sigma=parameterSetting{1}(i1);
        for i2=1:nValue(2)
            thr=parameterSetting{2}(i2);
            f=[f,FeatureClass3_4(P_dbm,sigma,thr)];
        end
    end
end
if fClass==3.47
    [S,F,T,P_dbm]=IQ2P_dbm(I,Q,256,256-16,NFFT,sampRate);
    parameterSetting={[0.1 0.2 0.5 1 2 5 10],[0.8]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    for i1=1:nValue(1)
        sigma=parameterSetting{1}(i1);
        for i2=1:nValue(2)
            thr=parameterSetting{2}(i2);
            f=[f,FeatureClass3_4(P_dbm,sigma,thr)];
        end
    end
end
if fClass==3.48
    [S,F,T,P_dbm]=IQ2P_dbm(I,Q,256,256-16,NFFT,sampRate);
    parameterSetting={[0.1 0.2 0.5 1 2 5 10],[0.9]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    for i1=1:nValue(1)
        sigma=parameterSetting{1}(i1);
        for i2=1:nValue(2)
            thr=parameterSetting{2}(i2);
            f=[f,FeatureClass3_4(P_dbm,sigma,thr)];
        end
    end
end
if fClass==3.49
    [S,F,T,P_dbm]=IQ2P_dbm(I,Q,128,128-16,NFFT,sampRate);
    parameterSetting={[0.1 0.2 0.5 1 2 5 10],[0.1 0.3 0.5 0.7 0.9]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    for i1=1:nValue(1)
        sigma=parameterSetting{1}(i1);
        for i2=1:nValue(2)
            thr=parameterSetting{2}(i2);
            f=[f,FeatureClass3_4(P_dbm,sigma,thr)];
        end
    end
end
if fClass==3.491
    [S,F,T,P_dbm]=IQ2P_dbm(I,Q,128,128-32,NFFT,sampRate);
    parameterSetting={[0.1 0.2 0.5 1 2 5 10],[0.1 0.3 0.5 0.7 0.9]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    for i1=1:nValue(1)
        sigma=parameterSetting{1}(i1);
        for i2=1:nValue(2)
            thr=parameterSetting{2}(i2);
            f=[f,FeatureClass3_4(P_dbm,sigma,thr)];
        end
    end
end
if fClass==3.492
    [S,F,T,P_dbm]=IQ2P_dbm(I,Q,64,64-16,NFFT,sampRate);
    parameterSetting={[0.1 0.2 0.5 1 2 5 10],[0.1 0.3 0.5 0.7 0.9]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    for i1=1:nValue(1)
        sigma=parameterSetting{1}(i1);
        for i2=1:nValue(2)
            thr=parameterSetting{2}(i2);
            f=[f,FeatureClass3_4(P_dbm,sigma,thr)];
        end
    end
end
if fClass==3.493
    [S,F,T,P_dbm]=IQ2P_dbm(I,Q,64,64-4,NFFT,sampRate);
    parameterSetting={[0.1 0.2 0.5 1 2 5 10],[0.1 0.3 0.5 0.7 0.9]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    for i1=1:nValue(1)
        sigma=parameterSetting{1}(i1);
        for i2=1:nValue(2)
            thr=parameterSetting{2}(i2);
            f=[f,FeatureClass3_4(P_dbm,sigma,thr)];
        end
    end
end
if fClass==3.494
    [S,F,T,P_dbm]=IQ2P_dbm(I,Q,64,64-16,NFFT,sampRate);
    parameterSetting={[0.1 0.2 0.5 1 2 5 10],[0.7]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    for i1=1:nValue(1)
        sigma=parameterSetting{1}(i1);
        for i2=1:nValue(2)
            thr=parameterSetting{2}(i2);
            f=[f,FeatureClass3_4(P_dbm,sigma,thr)];
        end
    end
end
if fClass==3.495
    [S,F,T,P_dbm]=IQ2P_dbm(I,Q,64,64-16,NFFT,sampRate);
    parameterSetting={[0.1 0.2 0.5 1 2 5 10],[0.5 0.6 0.7 0.8 0.9]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    for i1=1:nValue(1)
        sigma=parameterSetting{1}(i1);
        for i2=1:nValue(2)
            thr=parameterSetting{2}(i2);
            f=[f,FeatureClass3_4(P_dbm,sigma,thr)];
        end
    end
end
if fClass==3.496
    [S,F,T,P_dbm]=IQ2P_dbm(I,Q,64,64-16,NFFT,sampRate);
    parameterSetting={[1 2 5 10],[0.5 0.6 0.7 0.8 0.9]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    for i1=1:nValue(1)
        sigma=parameterSetting{1}(i1);
        for i2=1:nValue(2)
            thr=parameterSetting{2}(i2);
            f=[f,FeatureClass3_4(P_dbm,sigma,thr)];
        end
    end
end
if fClass==3.497
    [S,F,T,P_dbm]=IQ2P_dbm(I,Q,64,64-16,NFFT,sampRate);
    parameterSetting={[5 10],[0.5 0.6 0.7 0.8 0.9]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    for i1=1:nValue(1)
        sigma=parameterSetting{1}(i1);
        for i2=1:nValue(2)
            thr=parameterSetting{2}(i2);
            f=[f,FeatureClass3_4(P_dbm,sigma,thr)];
        end
    end
end
if fClass==3.498
    [S,F,T,P_dbm]=IQ2P_dbm(I,Q,64,64-16,NFFT,sampRate);
    parameterSetting={[5 10],[0.3 0.4 0.5 0.6 0.7 0.8 0.9]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    for i1=1:nValue(1)
        sigma=parameterSetting{1}(i1);
        for i2=1:nValue(2)
            thr=parameterSetting{2}(i2);
            f=[f,FeatureClass3_4(P_dbm,sigma,thr)];
        end
    end
end
if fClass==3.499
    [S,F,T,P_dbm]=IQ2P_dbm(I,Q,64,64-16,NFFT,sampRate);
    parameterSetting={[2 4 8 16 32],[0.3 0.4 0.5 0.6 0.7 0.8 0.9]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    for i1=1:nValue(1)
        sigma=parameterSetting{1}(i1);
        for i2=1:nValue(2)
            thr=parameterSetting{2}(i2);
            f=[f,FeatureClass3_4(P_dbm,sigma,thr)];
        end
    end
end
if fClass==3.4991
    [S,F,T,P_dbm]=IQ2P_dbm(I,Q,64,64-16,NFFT,sampRate);
    parameterSetting={[2 4 8 16],[0.3 0.4 0.5 0.6 0.7 0.8 0.9]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    for i1=1:nValue(1)
        sigma=parameterSetting{1}(i1);
        for i2=1:nValue(2)
            thr=parameterSetting{2}(i2);
            f=[f,FeatureClass3_4(P_dbm,sigma,thr)];
        end
    end
end
if fClass==3.4992
    [S,F,T,P_dbm]=IQ2P_dbm(I,Q,64,64-16,NFFT,sampRate);
    parameterSetting={[2 4 8 16 32 64],[0.3 0.4 0.5 0.6 0.7 0.8 0.9]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    for i1=1:nValue(1)
        sigma=parameterSetting{1}(i1);
        for i2=1:nValue(2)
            thr=parameterSetting{2}(i2);
            f=[f,FeatureClass3_4(P_dbm,sigma,thr)];
        end
    end
end



if fClass==3.5
    [S,F,T,P_dbm]=IQ2P_dbm(I,Q,256,256-16,NFFT,sampRate);
    parameterSetting={[0.1 0.2 0.5 1 2 5 10],[0.1 0.3 0.5 0.7 0.9]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    for i1=1:nValue(1)
        sigma=parameterSetting{1}(i1);
        for i2=1:nValue(2)
            thr=parameterSetting{2}(i2);
            f=[f,FeatureClass3_5(P_dbm,sigma,thr)];
        end
    end
end


if fClass==3.7
    parameterSetting={[32 64 128 256],[1/16 1/8 1/4],[0.1 0.2 0.5 1 2 5 10],[0.1 0.3 0.5 0.7 0.9]};
    %parameterSetting={[256],[1/4],[1],[0.6,0.65,0.7,0.75,0.8,0.85,0.9,0.95]};
    
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    for i1=1:nValue(1)
        WINDOW = parameterSetting{1}(i1);
        for i2=1:nValue(2)
            NOVERLAP=WINDOW*(1-parameterSetting{2}(i2));
            [S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,NFFT,sampRate);
            for i3=1:nValue(3)
                sigma=parameterSetting{3}(i3);
                for i4=1:nValue(4)
                    thr=parameterSetting{4}(i4);
                    f=[f,FeatureClass3_7(P_dbm,sigma,thr)];
                end
            end
        end
    end
end

if fClass==3.3
    [S,F,T,P_dbm]=IQ2P_dbm(I,Q,256,256-16,NFFT,sampRate);
    f=[f,FeatureClass3_3(P_dbm)];
end

% Class 4
if fClass==4
    parameterSetting={[32 64 128 256],[1/16 1/8 1/4],[0 1 2 3 4]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
 
    for i1=1:nValue(1)
        WINDOW =parameterSetting{1}(i1);
        for i2=1:nValue(2)
            NOVERLAP=WINDOW*(1-parameterSetting{2}(i2));
            [S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,NFFT,sampRate);
            [n,xout]=hist(P_dbm(:),-100:0.1:100);
            for i3=1:nValue(3)
                nStd = parameterSetting{3}(i3);
                hist_thr=median(P_dbm(:))+nStd*std(P_dbm(:));
                f=[f,FeatureClass4(P_dbm,n,xout,hist_thr)];
            end
        end
    end
end     

if fClass==4.3
    parameterSetting={[32 64 128 256],[1/16 1/8 1/4],[0 1 2 3 4]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
 
    for i1=1:nValue(1)
        WINDOW =parameterSetting{1}(i1);
        for i2=1:nValue(2)
            NOVERLAP=WINDOW*(1-parameterSetting{2}(i2));
            [S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,NFFT,sampRate);
            [n,xout]=hist(P_dbm(:),-100:0.1:100);
            for i3=1:nValue(3)
                nStd = parameterSetting{3}(i3);
                hist_thr=median(P_dbm(:))+nStd*std(P_dbm(:));
                f=[f,FeatureClass4_3(P_dbm,n,xout,hist_thr)];
            end
        end
    end
end 

if fClass==4.1
    parameterSetting={[32 64 128 256],[1/16 1/8 1/4],[10 20 30 40 50 60]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    for i1=1:nValue(1)
        WINDOW =parameterSetting{1}(i1);
        for i2=1:nValue(2)
            NOVERLAP=WINDOW*(1-parameterSetting{2}(i2));
            [S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,NFFT,sampRate);
            [n,xout]=hist(P_dbm(:),-100:0.1:100);
            for i3=1:nValue(3)
                hist_thr = parameterSetting{3}(i3);
                f=[f,FeatureClass4_1(P_dbm,n,xout,hist_thr)];
            end
        end
    end
end

if fClass==4.2
    parameterSetting={[32 64 128 256],[1/16 1/8 1/4],[0 1 2 3 4]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    for i1=1:nValue(1)
        WINDOW =parameterSetting{1}(i1);
        for i2=1:nValue(2)
            NOVERLAP=WINDOW*(1-parameterSetting{2}(i2));
            [S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,NFFT,sampRate);
            [n,xout]=hist(P_dbm(:),-100:0.1:100);
            for i3=1:nValue(3)
                hist_thr = parameterSetting{3}(i3);
                f=[f,FeatureClass4_2(P_dbm,n,xout,hist_thr)];
            end
        end
    end
end  


% Class 5
if fClass==5
    parameterSetting={[32 64 128 256],[1/16 1/8 1/4],[0 1 2 3 4],[0 1 2 3],[0.95 0.9]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    for i1=1:nValue(1)
        WINDOW =parameterSetting{1}(i1);
        for i2=1:nValue(2)
            NOVERLAP=WINDOW*(1-parameterSetting{2}(i2));
            [S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,256,300);
            numOfBins=length(T);
            for i3=1:nValue(3)
                nStd=parameterSetting{3}(i3);        
                thrPower=mean(P_dbm,2)+nStd*std(P_dbm,0,2);        % get thrPower         
                P_dbm_thr=(P_dbm>repmat(thrPower,1,numOfBins)).*P_dbm; 
                P_dbm_01=(P_dbm_thr~=0);
                for i4=1:nValue(4)
                    order=parameterSetting{4}(i4);
                    for i5=1:nValue(5)
                        quan=parameterSetting{5}(i5);
                        f=[f,FeatureClass5(P_dbm_01,F,order,quan)];
                    end
                end
            end
        end
    end
end


if fClass==5.2
    parameterSetting={[32 64 128 256],[1/16 1/8 1/4],[1 1.5 2 2.5 3 3.5]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    for i1=1:nValue(1)
        WINDOW =parameterSetting{1}(i1);
        for i2=1:nValue(2)
            NOVERLAP=WINDOW*(1-parameterSetting{2}(i2));
            [S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,256,300);
            for i3=1:nValue(3)
                nDelta=parameterSetting{3}(i3);     
                f=[f,FeatureClass5_2(P_dbm,nDelta)];
            end
        end
    end
end

if fClass==5.21
    parameterSetting={[32 64 128 256],[1/16 1/8 1/4],[0 0.5 1 1.5 2 2.5 3 3.5 4 5 6]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    for i1=1:nValue(1)
        WINDOW =parameterSetting{1}(i1);
        for i2=1:nValue(2)
            NOVERLAP=WINDOW*(1-parameterSetting{2}(i2));
            [S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,256,300);
            for i3=1:nValue(3)
                nDelta=parameterSetting{3}(i3);     
                f=[f,FeatureClass5_21(P_dbm,nDelta)];
            end
        end
    end
end

if fClass==5.22
    parameterSetting={[32 64 128 256],[1/16 1/8 1/4],[0 0.5 1 1.5 2 2.5 3 3.5 4 5 6]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    for i1=1:nValue(1)
        WINDOW =parameterSetting{1}(i1);
        for i2=1:nValue(2)
            NOVERLAP=WINDOW*(1-parameterSetting{2}(i2));
            [S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,256,300);
            for i3=1:nValue(3)
                nDelta=parameterSetting{3}(i3);     
                f=[f,FeatureClass5_22(P_dbm,nDelta)];
            end
        end
    end
end
    
if fClass==5.23
    parameterSetting={[32 64 128 256],[1/16 1/8 1/4],[5 10 15 20 25 30 35 40 45 50 55 60]};
    %parameterSetting={[256],[1/4],[10 15 20 25 30 35 40 45]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    for i1=1:nValue(1)
        WINDOW =parameterSetting{1}(i1);
        for i2=1:nValue(2)
            NOVERLAP=WINDOW*(1-parameterSetting{2}(i2));
            [S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,NFFT,sampRate);
            for i3=1:nValue(3)
                thr=parameterSetting{3}(i3);     
                f=[f,FeatureClass5_23(P_dbm,thr)];
            end
        end
    end
end

if fClass==5.24
    parameterSetting={[32 64 128 256],[1/16 1/8 1/4],[5 10 15 20 25 30 35 40 45 50 55 60]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    for i1=1:nValue(1)
        WINDOW =parameterSetting{1}(i1);
        for i2=1:nValue(2)
            NOVERLAP=WINDOW*(1-parameterSetting{2}(i2));
            [S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,256,300);
            for i3=1:nValue(3)
                thr=parameterSetting{3}(i3);     
                f=[f,FeatureClass5_24(P_dbm,thr)];
            end
        end
    end
end

if fClass==5.25
    parameterSetting={[32],[1/16 1/8 1/4],[5 10 15 20 25 30 35 40 45 50 55 60]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    for i1=1:nValue(1)
        WINDOW =parameterSetting{1}(i1);
        for i2=1:nValue(2)
            NOVERLAP=WINDOW*(1-parameterSetting{2}(i2));
            [S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,256,300);
            for i3=1:nValue(3)
                thr=parameterSetting{3}(i3);     
                f=[f,FeatureClass5_24(P_dbm,thr)];
            end
        end
    end
end

if fClass==5.26
    parameterSetting={[64],[1/16 1/8 1/4],[5 10 15 20 25 30 35 40 45 50 55 60]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    for i1=1:nValue(1)
        WINDOW =parameterSetting{1}(i1);
        for i2=1:nValue(2)
            NOVERLAP=WINDOW*(1-parameterSetting{2}(i2));
            [S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,256,300);
            for i3=1:nValue(3)
                thr=parameterSetting{3}(i3);     
                f=[f,FeatureClass5_24(P_dbm,thr)];
            end
        end
    end
end

if fClass==5.27
    parameterSetting={[256],[1/16 1/8 1/4],[5 10 15 20 25 30 35 40 45 50 55 60]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    for i1=1:nValue(1)
        WINDOW =parameterSetting{1}(i1);
        for i2=1:nValue(2)
            NOVERLAP=WINDOW*(1-parameterSetting{2}(i2));
            [S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,256,300);
            for i3=1:nValue(3)
                thr=parameterSetting{3}(i3);     
                f=[f,FeatureClass5_24(P_dbm,thr)];
            end
        end
    end
end

if fClass==5.28
    parameterSetting={[32 64 128 256],[1/16],[5 10 15 20 25 30 35 40 45 50 55 60]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    for i1=1:nValue(1)
        WINDOW =parameterSetting{1}(i1);
        for i2=1:nValue(2)
            NOVERLAP=WINDOW*(1-parameterSetting{2}(i2));
            [S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,256,300);
            for i3=1:nValue(3)
                thr=parameterSetting{3}(i3);     
                f=[f,FeatureClass5_24(P_dbm,thr)];
            end
        end
    end
end

if fClass==5.29
    parameterSetting={[32 64 128 256],[1/8],[5 10 15 20 25 30 35 40 45 50 55 60]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    for i1=1:nValue(1)
        WINDOW =parameterSetting{1}(i1);
        for i2=1:nValue(2)
            NOVERLAP=WINDOW*(1-parameterSetting{2}(i2));
            [S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,256,300);
            for i3=1:nValue(3)
                thr=parameterSetting{3}(i3);     
                f=[f,FeatureClass5_24(P_dbm,thr)];
            end
        end
    end
end

if fClass==5.30
    parameterSetting={[32 64 128 256],[1/4],[5 10 15 20 25 30 35 40 45 50 55 60]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    for i1=1:nValue(1)
        WINDOW =parameterSetting{1}(i1);
        for i2=1:nValue(2)
            NOVERLAP=WINDOW*(1-parameterSetting{2}(i2));
            [S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,256,300);
            for i3=1:nValue(3)
                thr=parameterSetting{3}(i3);     
                f=[f,FeatureClass5_24(P_dbm,thr)];
            end
        end
    end
end

if fClass==5.31
    parameterSetting={[256],[1/8],[5 10 15 20 25 30 35 40 45 50 55 60]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    for i1=1:nValue(1)
        WINDOW =parameterSetting{1}(i1);
        for i2=1:nValue(2)
            NOVERLAP=WINDOW*(1-parameterSetting{2}(i2));
            [S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,256,300);
            for i3=1:nValue(3)
                thr=parameterSetting{3}(i3);     
                f=[f,FeatureClass5_24(P_dbm,thr)];
            end
        end
    end
end

if fClass==5.32
    parameterSetting={[64],[1/4],[5 10 15 20 25 30 35 40 45 50 55 60]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    for i1=1:nValue(1)
        WINDOW =parameterSetting{1}(i1);
        for i2=1:nValue(2)
            NOVERLAP=WINDOW*(1-parameterSetting{2}(i2));
            [S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,256,300);
            for i3=1:nValue(3)
                thr=parameterSetting{3}(i3);     
                f=[f,FeatureClass5_24(P_dbm,thr)];
            end
        end
    end
end
if fClass==5.321
    parameterSetting={[256],[1/16],[5 10 15 20 25 30 35 40 45 50 55 60]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    for i1=1:nValue(1)
        WINDOW =parameterSetting{1}(i1);
        for i2=1:nValue(2)
            NOVERLAP=WINDOW*(1-parameterSetting{2}(i2));
            [S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,256,300);
            for i3=1:nValue(3)
                thr=parameterSetting{3}(i3);     
                f=[f,FeatureClass5_24(P_dbm,thr)];
            end
        end
    end
end
if fClass==5.322
    parameterSetting={[256],[1/8],[5 10 15 20 25 30 35 40 45 50 55 60]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    for i1=1:nValue(1)
        WINDOW =parameterSetting{1}(i1);
        for i2=1:nValue(2)
            NOVERLAP=WINDOW*(1-parameterSetting{2}(i2));
            [S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,256,300);
            for i3=1:nValue(3)
                thr=parameterSetting{3}(i3);     
                f=[f,FeatureClass5_24(P_dbm,thr)];
            end
        end
    end
end
if fClass==5.323
    parameterSetting={[256],[1/4],[5 10 15 20 25 30 35 40 45 50 55 60]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    for i1=1:nValue(1)
        WINDOW =parameterSetting{1}(i1);
        for i2=1:nValue(2)
            NOVERLAP=WINDOW*(1-parameterSetting{2}(i2));
            [S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,256,300);
            for i3=1:nValue(3)
                thr=parameterSetting{3}(i3);     
                f=[f,FeatureClass5_24(P_dbm,thr)];
            end
        end
    end
end
if fClass==5.324
    parameterSetting={[256],[1/2],[5 10 15 20 25 30 35 40 45 50 55 60]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    for i1=1:nValue(1)
        WINDOW =parameterSetting{1}(i1);
        for i2=1:nValue(2)
            NOVERLAP=WINDOW*(1-parameterSetting{2}(i2));
            [S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,256,300);
            for i3=1:nValue(3)
                thr=parameterSetting{3}(i3);     
                f=[f,FeatureClass5_24(P_dbm,thr)];
            end
        end
    end
end
if fClass==5.325
    parameterSetting={[128],[1/4],[5 10 15 20 25 30 35 40 45 50 55 60]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    for i1=1:nValue(1)
        WINDOW =parameterSetting{1}(i1);
        for i2=1:nValue(2)
            NOVERLAP=WINDOW*(1-parameterSetting{2}(i2));
            [S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,256,300);
            for i3=1:nValue(3)
                thr=parameterSetting{3}(i3);     
                f=[f,FeatureClass5_24(P_dbm,thr)];
            end
        end
    end
end
if fClass==5.326
    parameterSetting={[64],[1/4],[5 10 15 20 25 30 35 40 45 50 55 60]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    for i1=1:nValue(1)
        WINDOW =parameterSetting{1}(i1);
        for i2=1:nValue(2)
            NOVERLAP=WINDOW*(1-parameterSetting{2}(i2));
            [S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,256,300);
            for i3=1:nValue(3)
                thr=parameterSetting{3}(i3);     
                f=[f,FeatureClass5_24(P_dbm,thr)];
            end
        end
    end
end
if fClass==5.327
    parameterSetting={[32],[1/4],[5 10 15 20 25 30 35 40 45 50 55 60]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    for i1=1:nValue(1)
        WINDOW =parameterSetting{1}(i1);
        for i2=1:nValue(2)
            NOVERLAP=WINDOW*(1-parameterSetting{2}(i2));
            [S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,256,300);
            for i3=1:nValue(3)
                thr=parameterSetting{3}(i3);     
                f=[f,FeatureClass5_24(P_dbm,thr)];
            end
        end
    end
end
if fClass==5.328
    parameterSetting={[512],[1/4],[5 10 15 20 25 30 35 40 45 50 55 60]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    for i1=1:nValue(1)
        WINDOW =parameterSetting{1}(i1);
        for i2=1:nValue(2)
            NOVERLAP=WINDOW*(1-parameterSetting{2}(i2));
            [S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,256,300);
            for i3=1:nValue(3)
                thr=parameterSetting{3}(i3);     
                f=[f,FeatureClass5_24(P_dbm,thr)];
            end
        end
    end
end
if fClass==5.329
    parameterSetting={[64],[1/2],[5 10 15 20 25 30 35 40 45 50 55 60]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    for i1=1:nValue(1)
        WINDOW =parameterSetting{1}(i1);
        for i2=1:nValue(2)
            NOVERLAP=WINDOW*(1-parameterSetting{2}(i2));
            [S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,256,300);
            for i3=1:nValue(3)
                thr=parameterSetting{3}(i3);     
                f=[f,FeatureClass5_24(P_dbm,thr)];
            end
        end
    end
end
if fClass==5.3291
    parameterSetting={[64],[1/4],[5 10 15 20 25 30 35 40 45 50 55 60]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    for i1=1:nValue(1)
        WINDOW =parameterSetting{1}(i1);
        for i2=1:nValue(2)
            NOVERLAP=WINDOW*(1-parameterSetting{2}(i2));
            [S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,256,300);
            for i3=1:nValue(3)
                thr=parameterSetting{3}(i3);     
                f=[f,FeatureClass5_24(P_dbm,thr)];
            end
        end
    end
end

if fClass==5.3292
    parameterSetting={[64],[1/8],[5 10 15 20 25 30 35 40 45 50 55 60]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    for i1=1:nValue(1)
        WINDOW =parameterSetting{1}(i1);
        for i2=1:nValue(2)
            NOVERLAP=WINDOW*(1-parameterSetting{2}(i2));
            [S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,256,300);
            for i3=1:nValue(3)
                thr=parameterSetting{3}(i3);     
                f=[f,FeatureClass5_24(P_dbm,thr)];
            end
        end
    end
end

if fClass==5.3293
    parameterSetting={[128],[1/2],[5 10 15 20 25 30 35 40 45 50 55 60]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    for i1=1:nValue(1)
        WINDOW =parameterSetting{1}(i1);
        for i2=1:nValue(2)
            NOVERLAP=WINDOW*(1-parameterSetting{2}(i2));
            [S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,256,300);
            for i3=1:nValue(3)
                thr=parameterSetting{3}(i3);     
                f=[f,FeatureClass5_24(P_dbm,thr)];
            end
        end
    end
end

if fClass==5.3294
    parameterSetting={[128],[1/4],[5 10 15 20 25 30 35 40 45 50 55 60]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    for i1=1:nValue(1)
        WINDOW =parameterSetting{1}(i1);
        for i2=1:nValue(2)
            NOVERLAP=WINDOW*(1-parameterSetting{2}(i2));
            [S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,256,300);
            for i3=1:nValue(3)
                thr=parameterSetting{3}(i3);     
                f=[f,FeatureClass5_24(P_dbm,thr)];
            end
        end
    end
end

if fClass==5.3295
    parameterSetting={[128],[1/8],[5 10 15 20 25 30 35 40 45 50 55 60]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    for i1=1:nValue(1)
        WINDOW =parameterSetting{1}(i1);
        for i2=1:nValue(2)
            NOVERLAP=WINDOW*(1-parameterSetting{2}(i2));
            [S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,256,300);
            for i3=1:nValue(3)
                thr=parameterSetting{3}(i3);     
                f=[f,FeatureClass5_24(P_dbm,thr)];
            end
        end
    end
end

if fClass==5.3296
    parameterSetting={[128],[1/16],[5 10 15 20 25 30 35 40 45 50 55 60]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    for i1=1:nValue(1)
        WINDOW =parameterSetting{1}(i1);
        for i2=1:nValue(2)
            NOVERLAP=WINDOW*(1-parameterSetting{2}(i2));
            [S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,256,300);
            for i3=1:nValue(3)
                thr=parameterSetting{3}(i3);     
                f=[f,FeatureClass5_24(P_dbm,thr)];
            end
        end
    end
end
if fClass==5.3297
    parameterSetting={[64],[1/16],[5 10 15 20 25 30 35 40 45 50 55 60]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    for i1=1:nValue(1)
        WINDOW =parameterSetting{1}(i1);
        for i2=1:nValue(2)
            NOVERLAP=WINDOW*(1-parameterSetting{2}(i2));
            [S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,256,300);
            for i3=1:nValue(3)
                thr=parameterSetting{3}(i3);     
                f=[f,FeatureClass5_24(P_dbm,thr)];
            end
        end
    end
end
if fClass==5.32991
    parameterSetting={[64 128],[1/16],[5 10 15 20 25 30 35 40 45 50 55 60]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    for i1=1:nValue(1)
        WINDOW =parameterSetting{1}(i1);
        for i2=1:nValue(2)
            NOVERLAP=WINDOW*(1-parameterSetting{2}(i2));
            [S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,256,300);
            for i3=1:nValue(3)
                thr=parameterSetting{3}(i3);     
                f=[f,FeatureClass5_24(P_dbm,thr)];
            end
        end
    end
end
if fClass==5.3298
    parameterSetting={[64 128],[1/8 1/16],[5 10 15 20 25 30 35 40 45 50 55 60]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    for i1=1:nValue(1)
        WINDOW =parameterSetting{1}(i1);
        for i2=1:nValue(2)
            NOVERLAP=WINDOW*(1-parameterSetting{2}(i2));
            [S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,256,300);
            for i3=1:nValue(3)
                thr=parameterSetting{3}(i3);     
                f=[f,FeatureClass5_24(P_dbm,thr)];
            end
        end
    end
end
if fClass==5.3299
    parameterSetting={[64],[1/16],[0 5 10 15 20 25 30 35 40 45 50 55 60 65 70]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    for i1=1:nValue(1)
        WINDOW =parameterSetting{1}(i1);
        for i2=1:nValue(2)
            NOVERLAP=WINDOW*(1-parameterSetting{2}(i2));
            [S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,256,300);
            for i3=1:nValue(3)
                thr=parameterSetting{3}(i3);     
                f=[f,FeatureClass5_24(P_dbm,thr)];
            end
        end
    end
end
if fClass==5.32992
    parameterSetting={[64],[1/16],[5 10 15 20 25 30 35 40]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    for i1=1:nValue(1)
        WINDOW =parameterSetting{1}(i1);
        for i2=1:nValue(2)
            NOVERLAP=WINDOW*(1-parameterSetting{2}(i2));
            [S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,256,300);
            for i3=1:nValue(3)
                thr=parameterSetting{3}(i3);     
                f=[f,FeatureClass5_24(P_dbm,thr)];
            end
        end
    end
end

if fClass==5.32993
    parameterSetting={[64],[1/4],[5 7.5 10 12.5 15 17.5 20 22.5 25 27.5 30 32.5 35 37.5 40]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    for i1=1:nValue(1)
        WINDOW =parameterSetting{1}(i1);
        for i2=1:nValue(2)
            NOVERLAP=WINDOW*(1-parameterSetting{2}(i2));
            [S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,256,300);
            for i3=1:nValue(3)
                thr=parameterSetting{3}(i3);     
                f=[f,FeatureClass5_24(P_dbm,thr)];
            end
        end
    end
end
if fClass==5.32994
    parameterSetting={[64],[1/8],[5 7.5 10 12.5 15 17.5 20 22.5 25 27.5 30 32.5 35 37.5 40]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    for i1=1:nValue(1)
        WINDOW =parameterSetting{1}(i1);
        for i2=1:nValue(2)
            NOVERLAP=WINDOW*(1-parameterSetting{2}(i2));
            [S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,256,300);
            for i3=1:nValue(3)
                thr=parameterSetting{3}(i3);     
                f=[f,FeatureClass5_24(P_dbm,thr)];
            end
        end
    end
end
if fClass==5.32995
    parameterSetting={[64],[1/16],[5 7.5 10 12.5 15 17.5 20 22.5 25 27.5 30 32.5 35 37.5 40]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    for i1=1:nValue(1)
        WINDOW =parameterSetting{1}(i1);
        for i2=1:nValue(2)
            NOVERLAP=WINDOW*(1-parameterSetting{2}(i2));
            [S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,256,300);
            for i3=1:nValue(3)
                thr=parameterSetting{3}(i3);     
                f=[f,FeatureClass5_24(P_dbm,thr)];
            end
        end
    end
end


if fClass==5.33
    parameterSetting={[32 64 128 256],[1/16 1/8 1/4],[20]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    for i1=1:nValue(1)
        WINDOW =parameterSetting{1}(i1);
        for i2=1:nValue(2)
            NOVERLAP=WINDOW*(1-parameterSetting{2}(i2));
            [S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,256,300);
            for i3=1:nValue(3)
                thr=parameterSetting{3}(i3);     
                f=[f,FeatureClass5_24(P_dbm,thr)];
            end
        end
    end
end

if fClass==5.34
    parameterSetting={[32 64 128 256],[1/16 1/8 1/4],[20 30 40]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    for i1=1:nValue(1)
        WINDOW =parameterSetting{1}(i1);
        for i2=1:nValue(2)
            NOVERLAP=WINDOW*(1-parameterSetting{2}(i2));
            [S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,256,300);
            for i3=1:nValue(3)
                thr=parameterSetting{3}(i3);     
                f=[f,FeatureClass5_24(P_dbm,thr)];
            end
        end
    end
end

if fClass==5.4
    parameterSetting={[64],[1/4],[-1 0 1 2 3]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    for i1=1:nValue(1)
        WINDOW =parameterSetting{1}(i1);
        for i2=1:nValue(2)
            NOVERLAP=WINDOW*(1-parameterSetting{2}(i2));
            [S,F,T,P_dbm]=IQ2P_dbm(I,Q,WINDOW,NOVERLAP,256,300);
            for i3=1:nValue(3)
                thr=mean(P_dbm(:))+parameterSetting{2}(i2)*std(P_dbm(:));     
                f=[f,FeatureClass5_24(P_dbm,thr)];
            end
        end
    end
end




% Class 6
if fClass==6
    parameterSetting={[.01 .025 .05 .1 .2],[10 20 50 100 300 600],[.95 .9]}; 
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    [Range,Index]=doUnwrap(I,Q,sampRate);
    for i1=1:nValue(1)
        thr = parameterSetting{1}(i1);
        for i2=1:nValue(2)
            span = parameterSetting{2}(i2);   
            for i3=1:nValue(3)
                quan = parameterSetting{3}(i3);
                f=[f,FeatureClass6(Range,thr,span,quan)];
            end
        end
    end
end

if fClass==7
    f=FeatureClass7(I,Q);
end

if fClass==7.1
    parameterSetting={[0.05,0.1,0.2,0.4,0.5,0.6,0.8,0.9,0.95]};
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    for i1=1:nValue(1)
        quan=parameterSetting{1}(i1);
        f=[f,FeatureClass7_1(I,Q,quan)];
    end
end

if fClass==8.1
    parameterSetting={[400 500 600 700],[0 1 2 5 10],[0.5 0.9]};  
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    for i1=1:nValue(1)
        thr=parameterSetting{1}(i1);
        for i2=1:nValue(2)
            span = parameterSetting{2}(i2); 
            for i3=1:nValue(3)
                thrPercentage=parameterSetting{3}(i3);
                f=[f,FeatureClass8_1(I,Q,thr,span,thrPercentage)];
            end
        end
    end
end

if fClass==8.2
    parameterSetting={[50 100 200 400 600 800 1000]};  
    nParam=length(parameterSetting);
    for i0=1:nParam
        nValue(i0)=length(parameterSetting{i0}); 
    end
    
    for i1=1:nValue(1)
        thr=parameterSetting{1}(i1);
        f=[f,FeatureClass8_2(I,Q,thr)];
    end
end

if fClass==9.1
    parameterSetting={};
    nParam=length(parameterSetting);
    f=FeatureClass9_1(I,Q);
end

if fClass==9.11
    parameterSetting={};
    nParam=length(parameterSetting);
    f=FeatureClass9_11(I,Q);
end
if fClass==9.12
    parameterSetting={};
    nParam=length(parameterSetting);
    f=FeatureClass9_12(I,Q);
end

if fClass==9.2
    parameterSetting={};
    nParam=length(parameterSetting);
    f=FeatureClass9_2(I,Q);
end

if fClass==9.3
    parameterSetting={};
    nParam=length(parameterSetting);
    f=FeatureClass9_3(I,Q);
end

if fClass==10.1
    parameterSetting={};
    nParam=length(parameterSetting);
    f=FeatureClass10_1(I,Q);
end

if fClass==11.1
    parameterSetting={};
    nParam=length(parameterSetting);
    f=FeatureClass11_1(I,Q);
end
