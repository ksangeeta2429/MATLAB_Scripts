% test the relationship between fft in matlab and fft in emote.
% generate a file with (I,Q,I,Q...) format data that is from a sin wave


close all;
clear all;
len=256;
t=1:len
f=1/8;
fi=2*pi*f*t;
A=10000;
x=fix(A*cos(fi));
y=fix(A*sin(fi));
plot(t,x);
figure; plot(t,y);
z=fft(x+i*y)

% figure;
% plot(t,abs(y));

FID = fopen('C:/tmp.txt','w');
if FID==-1
    'Do not have this file!'
    return;
end
xy(1:2:2*len)=x;
xy(2:2:2*len)=y;
xy
for j=1:length(xy)-1
    fprintf(FID,'%d, ',xy(j));
end
j=length(xy);
fprintf(FID,'%d',xy(j));

fclose(FID);