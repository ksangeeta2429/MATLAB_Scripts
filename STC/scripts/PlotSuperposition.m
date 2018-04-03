close all;
t=0:0.001:1;
A1=2;
f1=50;
A2=30;
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

x1=A1*cos(fi1);
x2=A2*cos(fi2);
x3=x1+x2;
y1=A1*sin(fi1);
y2=A2*sin(fi2);
y3=y1+y2;

fi3=atan((y3)./(x3));
for i=1:length(t)
    if fi3(i)<0 && x3(i)<0 
        fi3(i)=fi3(i)+pi;
    else
        if fi3(i)>0 && x3(i)<0
            fi3(i)=fi3(i)-pi;
        end
    end
end
fi3=fi3/(2*pi);
fi3=fi3+0.5;
fi3=fi3-floor(fi3)-0.5;
fi3=2*pi*fi3;

subplot(2,1,1);
plot(t,x1,'b');hold on;
plot(t,x2,'g');
plot(t,x1+x2,'r');hold off;
legend('Weak Signal','Strong Signal','Superposed Signal','FontSize', 14);
xlabel('In-phase Component Intensity vs Time (s)','FontSize', 18);
set(gca,'FontSize',14);

% subplot(3,1,2);
% plot(t,fi1,'b');hold on;
% plot(t,fi2,'g');
% plot(t,fi3,'r');hold off;
% legend('Weak Signal','Strong Signal','Superposed Signal','FontSize', 14);
% xlabel('Instantaneous Phase of The Complex Signal (radians) vs Time (s)','FontSize', 14);

subplot(2,1,2);
nfft=512;
fs=1000;
mag1=abs(fft(x1+i*y1,nfft));mag1=[mag1(nfft/2+1:nfft) mag1(1:nfft/2)];
mag2=abs(fft(x2+i*y2,nfft));mag2=[mag2(nfft/2+1:nfft) mag2(1:nfft/2)];
mag3=abs(fft(x3+i*y3,nfft));mag3=[mag3(nfft/2+1:nfft) mag3(1:nfft/2)];
ff1=(0:length(mag1)-1)*fs/length(mag1);ff1=ff1-fs/2;
ff2=(0:length(mag2)-1)*fs/length(mag2);ff2=ff2-fs/2;
ff3=(0:length(mag3)-1)*fs/length(mag3);ff3=ff3-fs/2;
H1=plot(ff1,10*log(mag1.^2),'b--');hold on;
H2=plot(ff2,10*log(mag2.^2),'g-.');
H3=plot(ff3,10*log(mag3.^2),'r','LineWidth',2);
H4=plot(ff3,250*ones(1,length(mag3)),'k');
H5=plot(ff3,270*ones(1,length(mag3)),'k');hold off;
axis([-75,75,0,320]);
legend([H1 H2 H3 H4],'Weak Signal','Strong Signal','Superposed Signal','High/Low Threshold','FontSize', 14);
xlabel('Power(dB) vs Frequency (Hz)','FontSize', 18);
set(gca,'FontSize',14);