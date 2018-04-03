% time domain based event


function f=FeatureClass8_1(I,Q,thr,span,thrPercentage)
amp=((I-median(I)).^2+(Q-median(Q)).^2).^0.5;

N= length(amp);
counting=0;  %1 if counting, 0 if not

activeIntervals=[];
inactiveIntervals=[];

for i=1:N-span
    interval=i:i+span; % length is span+1
    ActivePercentage=length(find(amp(interval)>=thr))/(span+1); 
    % 100% if every moment is active, 0% if no moment is active, active means amplitude is greater than a thr     
    
    if ActivePercentage>=thrPercentage       % in time span, the active percentage is larger than a thr        
        if counting==0 %(0->1)
            counting=1;
            activTimerStart=i;
            if i~=1    % 如果一开始就是状态1的话，就不用存入第一个inactive interval了
                inactiveIntervals=[inactiveIntervals,i-inactiveTimerStart];
            end
            
        else % counting==1 %(1->1)
            % counting continue to be 1
            if i==span % 到尾巴了，强制完成这次的counting
                activeIntervals=[activeIntervals,(i+1-activTimerStart)];
            end
        end
        
    else % ActivePercentage < thrPercentage
        if counting==0  %(0->0)
            % counting continue to be 0           
            if i==1
                inactiveTimerStart=i; % 在开头，强制打开inactiveTimerStart
            end
            if i==span % 到尾巴了，强制完成这次的counting
                inactiveIntervals=[inactiveIntervals,(i+1-inactiveTimerStart)];
            end 
        else % counting==1 %(1->0)
            counting=0;
            inactiveTimerStart=i;
            activeIntervals=[activeIntervals,(i-activTimerStart)];
        end
    end
end

f(1)=length(activeIntervals);% # of active interval      
f(2)=sum(activeIntervals); % total active time  % expect to be good
f(3)=quantile(activeIntervals,0.9); % expect to be good
f(4)=quantile(activeIntervals,0.1);
f(5)=median(activeIntervals);
f(6)=var(activeIntervals); 

f(7)=length(inactiveIntervals);% # of active interval      
f(8)=quantile(inactiveIntervals,0.9); % expect to be good
f(9)=quantile(inactiveIntervals,0.1);
f(10)=median(inactiveIntervals);
f(11)=var(inactiveIntervals); % expect to be good



