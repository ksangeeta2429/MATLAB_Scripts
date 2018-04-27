%find continuous band in one column of AnomImage
%returns the index of continuous band
%for the sake of this script only lets define "band" as length N contiguous subset of column
%that is being inspected and "continuous band" as length >= N contiguous subset of column that 
%has atleast M out N excited bins in a sliding window of length N

function [start,stop] = getContinuousBand(Img_column,M,N)
	i = 1;
	num_bands = 0;
	start = [];
	stop = [];
	if(length(Img_column) <= N)
		if(sum(Img_column) < M)
			%no continuous band found
		end
	else
		flag = 0;
		for j = N:length(Img_column)
			temp = Img_column(i:j);
			if(sum(temp) >= M)
				%fprintf('%d %d %d\n',i,j,num_bands);
				if(flag == 1)
					stop(num_bands) = j;
				else
					%previous band was not continuous, found a new band.
					num_bands = num_bands + 1;
					%fprintf('Found new band...%d %d\n',i,j)
					start(num_bands) = i;
					stop(num_bands) = j;
					flag = 1;
				end
			else
				flag = 0;
			end
			i = i + 1;
		end
		%make sure there is no overlap between two bands.
		for i = 2:length(start)
			if(start(i) <= stop(i-1))
				start(i) = stop(i-1) + 1;
			end
		end
	start;
	stop;
end