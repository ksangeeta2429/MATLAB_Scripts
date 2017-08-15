function AmpFA(Path, Filename, M, N, color)

FullName = sprintf('%s/%s', Path,Filename);
Rate = 1024/3;
Mid = (N + 1)/2;

Comp = ReadComp(FullName);
NumSamp = length(Comp);

Time = [1:NumSamp]/Rate;

%Rot = UnWrap(angle(Comp)/2/pi);
Feat = MofN(abs(Comp), M,N);

%figure;
%subplot(2,1,1)
%plot(Time, abs(Comp), 'r');
%hold on;
%plot(Time(Mid : NumSamp - Mid + 1), Feat, 'b');
%hold off;
%axis tight

%subplot(2,1,2)
%plot(Time,Rot,'r');
%axis tight

NumFeat = length(Feat);
X = [1:NumFeat]/NumFeat;
%figure;
plot(sort(Feat),1-X, color);
