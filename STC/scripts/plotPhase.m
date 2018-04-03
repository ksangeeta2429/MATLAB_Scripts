% input: file name
% do: plot range (unwrapped range)

function plotPhase(fileName,SampRate,plotOffset,PLOTFRAMES)
data = ReadBin(fileName);
if PLOTFRAMES==1
    data=data(1+plotOffset:2*SampRate*30+plotOffset); 
end
[I,Q,N]=Data2IQ(data);


Index=[1:N]/SampRate;
[Range,Index]=doUnwrap(I,Q,SampRate);

%figure;
plot(Index,Range,'b');
% axis([0 N/SampRate -1 1]);
axis('tight');
% xlabel('Time (seconds)','FontSize', 14);
% ylabel('Unwrapped phase (m)','FontSize', 14);


