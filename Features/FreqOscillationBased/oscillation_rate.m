%{
input : Img - binary matrix (spectrogram with powers greater than a threshold indicated by 1).
		for more information on Img See AnomImage.m .
		Img here is complement of AnomImage.
		M and N - defines a continuous band. If M out of N bins are excited, it is 
		considered as continuous band.
output : number of cycles per second in the cut
There could be more than one continuous band at each step/column. Need to branch into each of
%these bands in time to find oscillations.
Use Depth First Search to find the oscillations in the spectrogram.
written by neel
%}

function [time_per_half_cycle,height,rate] = oscillation_rate(Img,FftStep,Rate,Freq,M,N,percentile)
	%x axis should be Time and y axis should be frequency
	%find continuous band
	min_freq = zeros(1,size(Img,2));
	max_freq = zeros(1,size(Img,2));
	found = 0; oscillation = 0;
	peak_frequencies = [];	peak_time_steps = [];
	for i = 1:size(Img,2) %for each column in spectrogram
		[start,stop] = getContinuousBand(Img(:,i),M,N);
		if(length(start) == 0)
			continue;
		end
		for j = 1:length(start) %for each continuous band
			index = start(j):1:stop(j);
			band_frequencies = Freq(index);
			[peak_frequencies,peak_time_steps,found,oscillation] = findOscillation(Img,M,N,Freq,i+1,start(j),stop(j));
			%if(oscillation == 0)
				%no oscillations
			%the band should cover atleast 70% of the time axis or the change in freq should be atleast 75 Hz
			%if(length(peak_time_steps) < round(0.7 * size(Img,2)) | abs(peak_frequencies(1)-peak_frequencies(length(peak_frequencies))) >= 75)
				%continue;
			%end
			%now check if these are actually oscillations with atleast 15 Hz change in frequency
			%for k = 1:length(peak_frequencies)
						
			%end
			if(found == 1)
				break;
			end
		end
		if(found == 1)
			break;
		end
	end

	found;
	oscillation;
	peak_frequencies;
	peak_time_steps;

	%plot(peak_time_steps,peak_frequencies);
	xlabel('Time Steps');
	ylabel('frequency');
	step = FftStep;
	step_secs = step/Rate;
	
	time_per_half_cycle = 0; rate = 0; height = 0;

	heights = diff(peak_frequencies);
	if(length(heights) > 0)
		position = round(length(heights)*percentile);
		%height = heights(position);
		height = mean(heights);
	end

	time = diff(peak_time_steps);
	if(length(time) > 0)
		position = round(length(time)*percentile);
		%time_per_half_cycle = time(position); %time from peak to peak
		time_per_half_cycle = mean(time);
	end
	rates = []; %number of peaks in one second
	i = 4;
	if(length(peak_time_steps) >= 4)
		while(i < length(peak_time_steps))
			rates = [rates step_secs*(peak_time_steps(i)-peak_time_steps(i-4+1))];
			i = i + 4;
		end
	end
	rates;
	if(length(rates) > 0)
		position = round(length(rates)*percentile);
		%rate = rate(position); %time from peak to peak
		rate = mean(rates);
	end
	fprintf('Length of heights : %d Rates : %d time steps : %d\n',length(heights),length(rates),length(time));
	fprintf('Height : %f , Rate : %f , time steps per half cycle : %f\n',height,rate,time_per_half_cycle)
end