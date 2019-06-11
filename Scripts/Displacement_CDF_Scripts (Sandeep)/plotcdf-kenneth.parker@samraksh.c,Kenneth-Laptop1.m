function PlotCdf(file, deltaT, color)

fid = fopen(sprintf('%s-cdf-%d.data',file,deltaT),'r');
Data = fread(fid,inf,'int16');
Data = Data * 5.1 / ( 400*pi);

N = length(Data);

I = [1:N] / N;
I(N) = (N-1)/N;

%figure;
Data = sort(Data);
plot(Data,log(1-I),color);
axis([0 2 -30 0]);
hold on;

[x(1),y(1),but] = ginput(1);
plot(x(1),y(1),'ko');

hold on;

[x(2),y(2),but] = ginput(1);
plot(x(2),y(2),'ko');

hold on;

startIndex = find(Data > x(1), 1, 'first');
stopIndex = find(Data < x(2), 1, 'last');

p = polyfit(Data(startIndex:stopIndex),log(1-I(startIndex:stopIndex))',1);
a = [0:0.05:1.8];
v = polyval(p,a);
plot(a,v,color);

hold on;
%{
l1 = [1 1];
l2 = [-30, 0];
plot(l1,l2,'k');
hold on;

l1 = [0.5 0.5];
l2 = [-30, 0];
plot(l1,l2,'k');
%}
%print('-dmeta',sprintf('%s_cdf_%dsec.emf',file,deltaT,nbins));
end