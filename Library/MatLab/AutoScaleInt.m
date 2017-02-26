function OutData = AutoScaleInt(InData, OutMinInt, OutMaxInt)

InMin = GlobalMin(InData);
InMax = GlobalMax(InData);
InRange = InMax - InMin;

OutMin = OutMinInt - 0.5;
OutMax = OutMaxInt + 0.5;

OutRange = OutMax - OutMin;
Scale = OutRange/InRange;

OutData = floor(Scale*(InData - InMin)) + OutMinInt;

%% Deal with round-up at the max
OutData = max(min(OutData, OutMaxInt), OutMinInt);

%% If efficency matters a lot we can rewrite this so that the
%% the output goes from 
%%
%%    OutMinInt - 0.5 + eps   to   OutMaxInt + 0.5 - eps.
%%
%% but doing this well requires that you factor all the expresions
%% so as to minimize roundoff, so the resulting code is messy.