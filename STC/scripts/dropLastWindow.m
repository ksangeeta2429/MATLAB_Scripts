function [I,Q,N] = dropLastWindow(I,Q,sampRate)
	N = length(I);
	if((rem(N,sampRate) ~= 0))
	if(rem(N,sampRate/2) == 0)
		%drop last samprate/2 samples
		t = fix(N/sampRate);
		I = I(1:t*sampRate);
		Q = Q(1:t*sampRate);
		N = length(I);
	end
	end
end