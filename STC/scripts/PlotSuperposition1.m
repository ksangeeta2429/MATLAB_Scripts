close all;
t=0:0.001:1;
A1=5;
f1=50;
A2=5;
f2=15;

fi1=2*pi*f1*t;
fi1=fi1/(2*pi);
fi1=fi1+0.5;
fi1=fi1-floor(fi1)-0.5;
fi1=2*pi*fi1;

fi2=2*pi*f2*t;
fi2=fi2/(2*pi);
fi2=fi2+0.5;
fi2=fi2-floor(fi2)-0.5;
fi2=2*pi*fi2;

x1=A1*cos(2*pi*(f2+10)*t)+A1*cos(2*pi*(f2+20)*t);%+A1*cos(fi1+2)+A1*cos(fi1+4)+A1*cos(fi1+6)+A1*cos(fi1+8);
y1=A1*cos(2*pi*(f2+10)*t)+A1*cos(2*pi*(f2+20)*t);;

x2=zeros(1,size(t,1));
y2=zeros(1,size(t,1));
for i=1:30
    x2=x2+A2*cos(2*pi*(f2+i)*t);
    y2=y2+A2*sin(2*pi*(f2+i)*t);
end

x3=x1+x2;
y3=y1+y2;



subplot(2,1,1);
%plot(t,x1,'b');hold on;
%plot(t,x2,'g');
plot(t,x1+x2,'r');%hold off;
axis([0.1,0.9,-200,200]);
%legend('Weak Signal','Strong Signal','Superposed Signal','FontSize', 14);
xlabel('In-phase Component Intensity vs Time (s)','FontSize', 18);
set(gca,'FontSize',14);


subplot(2,1,2);
nfft=512;
fs=1000;
mag1=abs(fft(x1+i*y1,nfft));mag1=[mag1(nfft/2+1:nfft) mag1(1:nfft/2)];
mag2=abs(fft(x2+i*y2,nfft));mag2=[mag2(nfft/2+1:nfft) mag2(1:nfft/2)];
mag3=abs(fft(x3+i*y3,nfft));mag3=[mag3(nfft/2+1:nfft) mag3(1:nfft/2)];
ff1=(0:length(mag1)-1)*fs/length(mag1);ff1=ff1-fs/2;
ff2=(0:length(mag2)-1)*fs/length(mag2);ff2=ff2-fs/2;
ff3=(0:length(mag3)-1)*fs/length(mag3);ff3=ff3-fs/2;
%plot(ff1,10*log(mag1.^2),'b');hold on;
%plot(ff2,10*log(mag2.^2),'g');
plot(ff3,10*log(mag3.^2),'r');
%plot(ff3,250*ones(1,length(mag3)),'k');
%plot(ff3,270*ones(1,length(mag3)),'k');
%hold off;
axis([-75,75,100,250]);
%legend('Weak Signal','Strong Signal','Superposed Signal','High Threshold','Low Threshold','FontSize', 14);
xlabel('Power(dB) vs Frequency (Hz)','FontSize', 18);
set(gca,'FontSize',14);