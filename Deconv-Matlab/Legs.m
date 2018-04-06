function Legs(Comp)

MaxF = 30;
MinF = 3;

[Spec,Freq,Time] = DeMod(Comp);
[N,M] = size(Spec);

FIndex = find((MinF < abs(Freq)) & (abs(Freq) < MaxF));
SubSet = abs(Spec(:,FIndex));

Energy = mean(SubSet,1);
Norm = SubSet ./ repmat(Energy, N,1);

Ridge = mean(Norm,2);

%%% graph ridge
figure(1)
plot(Ridge)

%% graph varance
figure(2)
% MySpect(Ridge, 128)
spectrogram(Ridge,48,48*(1-1/8),64,1024/3)