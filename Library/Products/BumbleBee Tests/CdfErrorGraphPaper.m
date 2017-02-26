function CdfErrorGraphPaper

N = 501;

PhiList = [-60 : 5 : 60];
M = length(PhiList);
Color = jet(M);

for i = 1:M
  Phi = (90 + PhiList(i)) * (pi/180);
  [Cdf,CumProp] = MakeCdf(Phi, N);
  CdfError = CumProp - (Cdf + 0.5);
  
  plot(Cdf,CdfError, 'Color',Color(i,:), 'LineWidth',1.5)
  hold on 
end
hold off

xlabel('Rotation');
ylabel('Error in CDF')

axis([-0.5 0.5, -0.2 0.2])

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Cdf,CumProp] = MakeCdf(Phi, N)

Phase = 2*pi*[0 : N-1]/(N-1);

True0 = cos(Phase);
True1 = sin(Phase);
TrueRot = atan2(True1,True0)/2/pi;

Base0 = [1 0];
Base1 = [cos(Phi), sin(Phi)];

Meas0 = True0*Base0(1) + True1*Base0(2);
Meas1 = True0*Base1(1) + True1*Base1(2);
MeasRot = atan2(Meas1,Meas0)/2/pi;

%% Graph in complex plane

Cdf = sort(MeasRot);
CumProp = ([0 : N-1] + 0.5) / N;

end