function Data = ReadPhase(File, SampRate)

Fid = fopen(File, 'r');
OutFile = strcat(File,'.emf');
if (Fid < 0)
  ERROR('Could not open file');
end

Data = fread(Fid, inf, 'int32');

N = length(Data);
Index = ([1:N])/SampRate;
figure;
plot (Index,Data,'b');
xlabel('Time (seconds)','FontSize', 14);
ylabel('Unwrapped phase','FontSize', 14);
%title('Histogram of cumulative displacement for background vs human targets','FontSize', 14);

print ('-dmeta', OutFile);
fclose('all');