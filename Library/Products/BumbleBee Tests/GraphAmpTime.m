function GraphAmpTime(Time,Comp)

plot(Time,abs(Comp), '.');

axis tight
xlabel('Time in Sec.')
ylabel('Amp. in ADC Units')