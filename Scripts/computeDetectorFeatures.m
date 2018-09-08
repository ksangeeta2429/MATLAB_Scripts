function f = computeDetectorFeatures(fileName)

f = [];

[I,Q,N]=Data2IQ(ReadBin([fileName,'.data']));
Comp = (I-median(I)) + 1i * (Q-median(Q));

%f1 - unwrapped phase
Range = UnWrap(angle(Comp)/2/pi, -0.5, 0.5)* 2*pi*4096;
u_phase = sum(abs(diff(Range)));

f = [f u_phase];

%median
med = median(abs(Comp));
f = [f med];

%percentiles
percentiles = [5,10,95,99];
for i = percentiles
    amp = prctile(abs(Comp),i);
    f = [f amp];
end

%absolute sum of the signal
abs_sum = sum(abs(Comp));
fileName;
f = [f abs_sum];
f = num2cell(f);
end

