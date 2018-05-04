function GraphDispDetection(Time, Comp, Threshold, IQRejection, matches, window, windowSize,save_times_to_file)

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

%get the start and stop times
%disp(displacementDetection);
start_times = []; stop_times = []; flag = 0;
for(i = 1:length(displacementDetection))
	if(displacementDetection(i) == 1)
		if(flag == 1)
			continue;
		else
			start_times = [start_times timePlot(i)];
			flag = 1;
		end	
	else
		if(flag == 1)
			stop_times = [stop_times timePlot(i-1)];
		end
		flag = 0;	
	end
end

%disp(timePlot);
%disp(start_times);
%disp(stop_times);

lengths = stop_times - start_times;
%disp(lengths);


%delete start and stop times of 0 length
zero_lengths = lengths == 0;
temp_start = []; temp_stop = []; temp_length = [];
for(i = 1:length(zero_lengths))
	if(zero_lengths(i) == 0)
		temp_start = [temp_start start_times(i)];
		temp_stop = [temp_stop stop_times(i)];
		temp_length = [temp_length lengths(i)]
	end
end

start_times = [];	stop_times = []; lengths = [];
start_times = temp_start;	stop_times = temp_stop;		lengths = temp_length;


if(save_times_to_file == 1)

%save the start times of the events to a file with name following format : detect_beginnings__date_relevantname
beginnings = '/home/neel/box.com/All_programs_data_IPSN_2016/Simulation/toDhruboMichael/Data_Repository/Bike data/Oct 21 2017/Detect_begs_and_ends/c1/detect_beginnings__r1_x';
fd = fopen(beginnings,'w');
for(i = 1:length(start_times))
	temp = start_times(i);
	fprintf(fd,'%d\n',temp);
end
fclose(fd);

%save the stop times of the events to a file with name following format : detect_ends__date_relevantname
ends = '/home/neel/box.com/All_programs_data_IPSN_2016/Simulation/toDhruboMichael/Data_Repository/Bike data/Oct 21 2017/Detect_begs_and_ends/c1/detect_ends__r1_x';
fd1 = fopen(ends,'w');
for(i = 1:length(stop_times))
	temp = stop_times(i);
	fprintf(fd1,'%d\n',temp);
end
fclose(fd1);

%save the length of the events to a file with name following format : detect_lengths__date_relevantname.
lengths_path = '/home/neel/box.com/All_programs_data_IPSN_2016/Simulation/toDhruboMichael/Data_Repository/Bike data/Oct 21 2017/Detect_begs_and_ends/c1/detect_lengths__r1_x';
fd1 = fopen(lengths_path,'w');
for(i = 1:length(lengths))
	temp = lengths(i);
	fprintf(fd1,'%d\n',temp);
end
fclose(fd1);
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



