function Fit(T,V, TLow,THigh)

Index = find((LowT < T) & (T < HighT));

SubT = T(Index) - T(Index(1));
SubV = SlopeSign * (VAsym - V(Index));

%% Est Tau
semilogy(SubT,SubV, 'Marker','.');

[TLim,Trash] = ginput(1);
Index = find(SubT < TLim);

SubSubT = SubT(Index);
SubSubV = SubV(Index);

semilogy(SubSubT*Nano, -SlopeSign*SubSubV, 'Marker','.')
hold on

Fit = polyfit(SubSubT, log(SubSubV),1);
Tau = -1/Fit(1);

FitV = exp(polyval(Fit,SubSubT));
plot(SubSubT*Nano, -SlopeSign*FitV, 'r','LineWidth',2)
hold off