function RadarSegmentCDF(FileName_IQ, Rate)

Comp = ReadRadarBiasSubtracted(FileName_IQ); % Optional second argument: 'complex', 'modiplusmodq', 'iplusq' (default)
figure;

N = length(Comp);

[Time,Unit] = PickTimeScale(N,Rate);

plot(Time,abs(Comp));
axis tight
xlabel(sprintf('Time in %s', Unit));
ylabel('Amp (ADC Units)');

[Range,Index] = SelectRange(Time);
MarkRange(Range);

Temp = Comp(Index);
AbsTemp = abs(Temp);

figure;
cdfplot(AbsTemp);

p = input('Enter percentile. Hit return to exit: ');
while(not(isempty(p)))
    prctile(AbsTemp,p)
    p = input('Enter percentile. Hit return to exit: ');
end
    