function GraphDispDetection(Time, Comp, Threshold, IQRejection, matches, window, windowSize)

if any(size(Time) ~= size(Comp))
  if length(Time) == length(Comp)
    error('Column-vector vs row-vector mismatch')
  else
    error('Input data size mismatch')
  end
end

N = length(Time);

UnRot = UnWrap(angle(Comp)/2/pi, -0.5, 0.5);

thresholdPerWindow = Threshold * windowSize

MaxHz = 0;

dispDetection = 0;
maxWindow = 0;
minWindow = 0;
diffWindow = 0;
timePlot = 0;
displacementDetection=0;

windowCount = (Time(length(Time))/windowSize);
windowLength = floor(N/windowCount);
for i=1:(windowCount-window)
    maxWindow(i) = max(UnRot(windowLength*i:windowLength*(i+1)));
    minWindow(i) = min(UnRot(windowLength*i:windowLength*(i+1)));
    diffWindow(i) = maxWindow(i) - minWindow(i);
    timePlot(i) = Time(i*windowLength);
end

for i=window+1:(windowCount-window)
    matchCount = 0;
    for (j=1:window)
        if (diffWindow(i-j) > thresholdPerWindow)
            matchCount = matchCount + 1;
        end
    end
    if (matchCount >= matches)
        displacementDetection(i) = 1;
    else
        displacementDetection(i) = 0;
    end
end

plot(timePlot,displacementDetection);
xlim([Time(1) Time(N)])
ylim([-0.1 1.2])
xlabel(['Threshold: ',num2str(Threshold),' window: ',num2str(matches), ' of ', num2str(window), ' size ', num2str(windowSize)])
ylabel('Displacement detection ')

% Temp = Time + D;
% Mask = Temp <= Time(N);
% TimeHigh = Temp(find(Mask));
% 
% Index = [1 : length(TimeHigh)];
% MidTime = (TimeHigh + Time(Index)) / 2;
% 
% UnRotHigh = interp1(Time,UnRot, TimeHigh);
% Disp = UnRotHigh - UnRot(Index);
% Hz = abs(Disp)/D;
% 
% dispDetection = 0;
% for i=1:length(Hz)
%   if(Hz(i) > Threshold)
%       dispDetection(i) = 1;
%   else
%       dispDetection(i) = 0;
%   end
% end
% 
% MaxHz = max(MaxHz, max(Hz));
% plot(MidTime,dispDetection)


%ylim([0 1.2])



