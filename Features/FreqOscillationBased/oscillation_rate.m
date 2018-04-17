%{
input : Img - binary matrix (spectrogram with powers greater than a threshold indicated by 1).
		See AnomImage.m for more information on Img
		M and N - defines a continuous band. If M out of N bins are excited, it is 
		considered as continuous band.
output : number of cycles per second in the cut
There could be more than one continuous band at each step/column. Need to branch into each of
%these bands in time to find oscillations.
Use Depth First Search to find the oscillations in the spectrogram.
written by neel
%}

function Out = oscillation_rate(Img,Freq,M,N)
	%x axis should be Time and y axis should be frequency
	%find continuous band
	min_freq = zeros(1,size(Img,2));
	max_freq = zeros(1,size(Img,2));
	for i = 1:size(Img,2) %for each column in spectrogram
		getContinuousBand(Img(:,i),M,N);
		%find max and min frequency
		Index = find(Img(:,i)); 
		max_freq(i) = max(Freq(Index));
		min_freq(i) = min(Freq(Index));

	end
end