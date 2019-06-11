function handle=PlotCdfs_MASS(file,style)
fid = fopen(file,'r');
Data = fread(fid,inf,'float');
%Data = Data * 5.1 / ( 400*pi);
BumbleBee;
Data = Data*lambda/2;

N = length(Data);

I = [1:N] / N;
I(N) = (N-1)/N;

%figure;

Data = sort(Data);
handle=plot(Data,log(1-I),style, 'LineWidth',1);
col = get(handle, 'Color');
%axis([0 3 -30 0]);
%axis([0 1.8 -20 0]);
%axis([0 0.5 -20 0]);
ylim([-20 0]);
hold on;

[x(1),y(1),but] = ginput(1);
%plot(x(1),y(1),'ko');
plot(x(1),y(1));

hold on;

[x(2),y(2),but] = ginput(1);
%plot(x(2),y(2),'ko');
plot(x(2),y(2));

hold on;

startIndex = find(Data > x(1), 1, 'first');
stopIndex = find(Data < x(2), 1, 'last');

p = polyfit(Data(startIndex:stopIndex),log(1-I(startIndex:stopIndex))',1);
a = [0:0.05:1.0];
v = polyval(p,a);
plot(a,v,'-.','Color',col,'LineWidth',1);

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