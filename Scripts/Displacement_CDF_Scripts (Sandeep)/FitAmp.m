function FitAmp(Comp, StopDist, M,N)

C = 2.99792458e8;
lambda = C/5.8e9;
Rate = 1024/3;

%% Start computaiton
Rot = UnWrap(angle(Comp)/2/pi);

figure(1)
Lim = GetRegion(Rot);
Index = [Lim(1) : Lim(2)];
NumSamp = length(Index);

Time = [Lim(1) : Lim(2)]/Rate;
Range = lambda/2 * ( -Rot(Index(NumSamp)) + Rot(Index)) + StopDist;

Feat = MofN(abs(Comp(Index)), M,N);

%% Graph
figure(2)
subplot(2,1,1)

Mid = (N+1)/2;
plot(Time(Mid : NumSamp - Mid  + 1), Feat);
axis tight

subplot(2,1,2)
plot(Time,Range,'r');
axis tight