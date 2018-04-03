% Time domain based event features


function f=eventFeatures(I, Q, thr)

%I=[100, 101, 110, 90, 111, 100, 99, 109, 91, 91, 100];
%Q=[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
%thr=4;

amp=((I-median(I)).^2+(Q-median(Q)).^2).^0.5;
amp1=abs(I-median(I));
amp2=abs(Q-median(Q));

N=length(amp);

counting=0;  %1 if counting, 0 if not
count=0;     % # of happen
totalTime=0;         % total happening time

counting1=0;  %1 if counting, 0 if not
count1=0;     % # of happen
totalTime1=0;         % total happening time

counting2=0;  %1 if counting, 0 if not
count2=0;     % # of happen
totalTime2=0;         % total happening time


for i=1:N
    if amp(i)>=thr       
        if counting==0 
            counting=1;
            count=count+1;
            timerStart=i;
        else % counting==1
                       % counting continue to be 1
        end 
    else % Range(i+span)-Range(i)<thr
        if counting==0
                       % counting continue to be 0        
        else % counting==1
            counting=0;
            totalTime=totalTime+(i-timerStart);
        end
    end
    if i==N && amp(i)>thr % µ½Î²°ÍÁË£¬µ«½áÊø²»ÁËÕâ´ÎµÄcounting
        totalTime=totalTime+(i+1-timerStart);
    end
    
    
    if amp1(i)>=thr       
        if counting1==0 
            counting1=1;
            count1=count1+1;
            timerStart1=i;
        else % counting==1
                       % counting continue to be 1
        end        
    else % Range(i+span)-Range(i)<thr
        if counting1==0
                       % counting continue to be 0        
        else % counting==1
            counting1=0;
            totalTime1=totalTime1+(i-timerStart1);
        end
    end
    if i==N && amp1(i)>thr % µ½Î²°ÍÁË£¬µ«½áÊø²»ÁËÕâ´ÎµÄcounting
        totalTime1=totalTime1+(i+1-timerStart1);
    end
    
    

    if amp2(i)>=thr       
        if counting2==0 
            counting2=1;
            count2=count2+1;
            timerStart2=i;
        else % counting==1
                       % counting continue to be 1
        end
    else % Range(i+span)-Range(i)<thr
        if counting2==0
                       % counting continue to be 0        
        else % counting==1
            counting2=0;
            totalTime2=totalTime2+(i-timerStart2);
        end
    end
    if i==N && amp2(i)>thr % µ½Î²°ÍÁË£¬µ«½áÊø²»ÁËÕâ´ÎµÄcounting
        totalTime2=totalTime2+(i+1-timerStart2);
    end
    
end

f = zeros(1,6);
f(1)=count;
f(2)=totalTime;

f(3)=count1;
f(4)=totalTime1;

f(5)=count2;
f(6)=totalTime2;