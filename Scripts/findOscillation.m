%{

find oscillation in frequency starting from a given time step
return start and stop points of oscillation along with information about whether the frequency
first started increasing of decreasing.
input : Img - AnomImage
		 M,N - M out N excited bins for continuous band
		 time_step - Column in spectrogram from where you are trying to find oscillation
		 low_j - lower index of band found in previous time step
		 high_j - higher index of band found in previous time step
		 Previous time step is when this function is called from oscillation_rate.m
output : min_band_freq - minimum frequency of the band at each time step
		 max_band_freq - maximum frequency of the band at each time step
		 This information can be used to find the height of the oscilation

%}

function [peak_frequencies,peak_time_steps,found,oscillation] = findOscillation(Img,M,N,Freq,time_step,l_j,h_j)
	disp('In findOscillation');
	no_band = 0;
	min_band_freq = []; max_band_freq = []; center_band_freq = [];
	time_steps = []; peak_i = 0;
	low_j = l_j; high_j = h_j;
	peak_frequencies = [];
	peak_time_steps = [];
	increasing = 0; found = 0;
	for i = time_step:size(Img,2)
		found = 0;
		i;
		[start, stop] = getContinuousBand(Img(:,i),M,N)
		j = 1;
		while(found == 0 & j <= length(start))
			%if(abs(start(j) - low_j) < 3 | abs(start(j) - high_j) < 3 | abs(stop(j) - low_j) < 3 | abs(stop(j) - high_j) < 3)
			%There should be some overlap between the continuous bands at two timesteps 
			if((high_j < start(j) & high_j >= stop(j)) | (high_j > start(j) & low_j <= stop(j)))	
				temp = increasing;
				%found a continuous band at time_step which is close to band in previous time step
				fprintf('Found contiguous band at time step %d, j = %d\n',i,j);
				found = 1;
				if(i > time_step)
					%if there are more than one continuous bands close to previous time step
					%choose the one that is decreasing if frequency is currently decreasing or 
					%increasing if  currently increasing
					for k = j:length(start)
						k;
						if((low_j < start(k) & low_j >= stop(k))) 
							%found a band that is increasing in frequency
							if(temp == 1)
								j = k;
								break;
							end
						elseif((low_j > start(k) & high_j <= stop(k)))
							%found a band that is decreasing in frequency
							if(temp == 0)
								j = k;
								break;
							end
						end
					end	
				end
				index = find(Img(start(j):stop(j),i));
				index = index + start(j) - 1;
				min_band_freq = [min_band_freq min(Freq(index))];
				max_band_freq = [max_band_freq max(Freq(index))];
				avg = Freq(round((start(j)+stop(j))/2));
				center_band_freq = [center_band_freq avg];
				peak_i = peak_i + 1;
				time_steps = [time_steps i];
				low_j = start(j); high_j = stop(j);
				if(length(min_band_freq) > 1 & center_band_freq(peak_i) >= center_band_freq(peak_i-1))
					if(increasing == 0)
						peak_frequencies = [peak_frequencies center_band_freq(peak_i-1)]
						peak_time_steps = [peak_time_steps time_steps(peak_i-1)]
						increasing = 1;
					end	
				elseif(length(min_band_freq) > 1 & center_band_freq(peak_i) < center_band_freq(peak_i-1))
					if(increasing == 1)
						%frequency was increasing, but at this point starts decreasing. Store this point and frequency.
						increasing = 0;
						peak_frequencies = [peak_frequencies center_band_freq(peak_i-1)]
						peak_time_steps = [peak_time_steps time_steps(peak_i-1)]
					end
				end	
				j = j + 1;
				
			else
				continue	
			end
		end
	end

%{
%record the time steps where frequency starts increasing or decreasing
peak_frequencies = [];
peak_time_steps = [];
increasing = 0;
for i = 2:length(min_band_freq)
	if(center_band_freq(i) >= center_band_freq(i-1))
		if(increasing = 0)
			peak_frequencies = [peak_frequencies center_band_freq(i-1)];
			peak_time_steps = [peak_time_steps time_steps(i-1)];
			increasing = 1;
		end	
	else
		if(increasing == 1)
			%frequency was increasing, but at this point starts decreasing. Store this point and frequency.
			increasing = 0;
			peak_frequencies = [peak_frequencies center_band_freq(i-1)];
			peak_time_steps = [peak_time_steps time_steps(i-1)];
		end
	end	
end
%}
disp('Checing peak frequencies for oscillation');
%check if the peak frequencies are alternatively increasing and decreasing
increasing = 0;
oscillation = 1;
peak_diff = abs(diff(peak_frequencies));
if(mean(peak_diff(2:length(peak_diff))) < 25)
	%not oscillations
	oscillation = 0;
else
if(length(peak_frequencies) < 4)
	%no oscillations. At least one cycle required.
	oscillation = 0;
	found = 0;
else
	for i = 2:length(peak_frequencies) 
		%skip the first one as it may be a start point and not a peak
		if(peak_frequencies(i+1) > peak_frequencies(i))
			if(increasing == 1 | peak_diff(i) < 25)
				oscillation = 0;
			end
			increasing = 1;
		elseif(peak_frequencies(i+1) < peak_frequencies(i))
			if(increasing == 0 | peak_diff(i) < 25)
				oscillation = 0;
			end
			increasing = 0;
		end
	end
end
end

end