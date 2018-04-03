function plotDataMicrophone(fileName, SampRate, plotOffset,PLOTFRAMES)
%SampRate=300;

%OutFile = sprintf('%s.emf', fileName);

data = ReadBin(fileName);
if PLOTFRAMES==1
    data=data(1+plotOffset:SampRate*30+plotOffset); 
end

N = length(data);
Index = [1:N]/SampRate;



% %%%% filter %%%%%%%%%%%%%%%%%%%%
% signal=(I-median(I))+i*(Q-median(Q));
% signal1=timeseries(signal,Index);
% 
% interval=[-10 10];
% idealfilter_signal = idealfilter(signal1,interval,'pass');
% 
% 
% %plot(signal1.Time,abs(signal1.Data),'r-')
% plot(idealfilter_signal.Time,real(idealfilter_signal.Data),'r-'),grid on, hold on
% plot(idealfilter_signal.Time,imag(idealfilter_signal.Data),'g-'),hold off
% axis([0 N/SampRate -1000 1000]);


%%%%%%%%%%%%%% figures %%%%%%%%%%%%%
plot(Index,data-median(data),'r'),
axis([0 N/SampRate -1000 1000]);
title('I and Q');


% % thr=300;
% % span=100;
% % thrPercentage=0.9;
% % 
% % amp=abs((I-median(I))+i*(Q-median(Q)));
% % event=zeros(1,N-span);
% % for j=1:N-span
% %     interval=j:j+span; % length is span+1
% %     ActivePercentage=length(find(amp(interval)>=thr))/(span+1); 
% %     if ActivePercentage>=thrPercentage
% %         event(j)=thr;
% %     else
% %         event(j)=0;
% %     end
% % end
% % 
% % plot(Index,amp,'r-');hold on;grid on;
% % plot(Index(1+span/2:N-span/2),event); hold off;
% % %plot([0 N/SampRate],[thr thr],'-');
% % axis([0 N/SampRate 0 1500]);



% figure;
% plot(Index,((I-median(I)).^2+(Q-median(Q)).^2).^0.5,'b');
% axis([0 N/SampRate 0 1500]);
% title('|I+iQ|');

%legend('I','Q');
%xlabel('Time (seconds)','FontSize', 14);
%ylabel('Radar amplitude in ADC units','FontSize', 14);
%title('Histogram of cumulative displacement for background vs human targets','FontSize', 14);

%print ('-dmeta', OutFile);
fclose('all');
