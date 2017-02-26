function Tau = EstTau(T,V,SlopeSign, GraphName, Other)

Nano = 1e9;

%% Pick range
plot(T,V, 'Marker','.')
if (4 < nargin)
  hold on
  plot(T,Other,'r', 'Marker','.')
  hold off
end

[LowT,Trash] = ginput(1);
[HighT,Trash] = ginput(1);
[Trash,VAsym] = ginput(1);

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

if (0 < SlopeSign)
  legend({'Scope Data', sprintf('Tau = %e', Tau)}, 'Location','NorthWest')
else
  legend({'Scope Data', sprintf('Tau = %e', Tau)}, 'Location','NorthEast')
end

axis tight
xlabel('Time in Nano-Seconds')
ylabel('Volts')
title(GraphName)

% SaveFigure(GraphName,5,3, '-dmeta',[0.6 0.5 0.4 0.2])