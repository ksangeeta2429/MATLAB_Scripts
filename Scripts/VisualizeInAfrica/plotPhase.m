% input: file name
% do: plot range (unwrapped range)

function plotPhase(fileName,SampRate,frameSeconds,plotOffset,PLOTFRAMES)
% OutFile = strcat(fileName,'.phase.emf');

data = ReadBin([fileName,'.data']);


if PLOTFRAMES==1
    data=data(1+plotOffset:(2*SampRate*frameSeconds)+plotOffset); 
end


[I,Q,N]=Data2IQ(data);



Index=([1:length(I)])/SampRate;

dc_I = median(I);
dc_Q = median(Q);

% step=128;
% dc_I = zeros(N,1);
% dc_Q = zeros(N,1);
% dc_I(1:step) = median(I);
% dc_Q(1:step) = median(Q);
% for i=step+1:N
%     dc_I(i) = median(I(i-step:i-1)); 
%     dc_Q(i) = median(Q(i-step:i-1));
% end

Data= (I-dc_I) + 1j*(Q-dc_Q);


% a trick to make the phase does not change when I Q are both very small,
% to reject the phase drift in background noise
% added 2/24/2015

% smallIQtoReject=10;
% for i=2:length(Data)
%     if (I(i)-dc_I<smallIQtoReject) && (Q(i)-dc_Q<smallIQtoReject)
%         Data(i)=Data(i-1);
%     end
% end



Range = UnWrap(angle(Data)/2/pi, -0.5, 0.5)* 2*pi*4096/1e6;






% Range = Range((256*85):(256*90));
% WindowSamples = round(0.25*256);
% OverlapSamples = round(0*256);
% N = length(Range);
% 
% if (N < WindowSamples)
%     phaseDiff = max(Range) - min(Range);
% else
%     k = 1;
%     find max-min over each window
%     for j = 1:(WindowSamples-OverlapSamples):(N + 1 - WindowSamples)
%         startIndex = j; 
%         stopIndex = j+WindowSamples-1;
%         phaseDiff(k) = abs(Range(stopIndex)-Range(startIndex));%max(Range(startIndex:stopIndex)) - min(Range(startIndex:stopIndex));
%         
%         currphase = Range(startIndex:startIndex+63)
%         maxPhaseInStep = max(Range(startIndex:startIndex+63))
% 
%         k = k + 1;
%     end
% end
% phaseDiff
% Range
% phaseDiff = sort(phaseDiff);
% figure;plot(phaseDiff,(1:length(phaseDiff))/length(phaseDiff));
% axis tight;
% xlabel('Unwrapped phase (m)','FontSize', 20);
% ylabel('Cdf','FontSize', 20);








figure;
% hold on;

plot(Index(1:length(Range)),Range,'b');
axis tight;
%axis([0 N/SampRate -10e6 10e6]);
xlabel('Time (s)','FontSize', 20);
ylabel('Unwrapped phase (m)','FontSize', 20);


% index1 = 256*201+1:256*214;
% index2 = 256*223+1:256*236;
% index3 = 256*235+1:256*248;
% index4 = 256*239+1:256*242;
% figure;plot((1:13*256)/256,Range(index1)-7,'b');
% hold on;
% plot((1:13*256)/256,Range(index2)-1.7,'r');
% plot((1:13*256)/256,Range(index3)+3.3,'g');
% hold off;
% figure;plot((4*256+1:7*256)/256,Range(index4)+3.3,'g');




% print ('-dmeta', OutFile);
fclose('all');

