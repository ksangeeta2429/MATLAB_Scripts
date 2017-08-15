cd('C:\Users\royd\Desktop\SenSys10\data\0-amplitude\radial\runs\cut');
fileFullNames=dir('*.data');
UnRots=[];
for j=1:length(fileFullNames)
    Comp=ReadRadar(fileFullNames(j).name);
    UnRots = [UnRots, (UnWrap(angle(Comp)/2/pi, -0.5, 0.5))'];
end

cd('C:\Users\royd\Desktop');
cumData=NoiseCdf_IPSN(UnRots,'walks_radial',250,0.5);

Data=cumData;
BumbleBee;
Data = Data * lambda/2;
Data=diff(Data);
N = length(Data);

I = [1:N] / N;
I(N) = (N-1)/N;

figure;

Data = sort(Data);
plot(Data,(1-I),'-b','LineWidth',2);