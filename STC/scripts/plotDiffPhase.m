% input: file name
% do: plot differentiated range

function plotDiffPhase(fileName,SampRate,plotOffset,PLOTFRAMES,span)
data = ReadBin(fileName);
if PLOTFRAMES==1
    data=data(1+plotOffset:18000+plotOffset); 
end
[I,Q,N]=Data2IQ(data);
Index=([1:N])/SampRate;
[Range,Index]=doUnwrap(I,Q,SampRate);

for i=1:N-span
    diffRange(i)=Range(i+span)-Range(i);
end

%figure;
plot(Index(1:N-span),diffRange,'b');
axis([0 (N-span)/SampRate -0.05 0.05]);
% xlabel('Time (seconds)','FontSize', 14);
% ylabel('Unwrapped phase (m)','FontSize', 14);


