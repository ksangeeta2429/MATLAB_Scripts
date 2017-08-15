function PairGraph(Comp, Rate)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PairGraph -- Graph the real and imaginary pair one above the other

N = length(Comp);
Time = [0 : N-1]/Rate;

subplot(2,1,1);
plot(Time, real(Comp), 'marker','.');
axis tight

subplot(2,1,2);
plot(Time, imag(Comp), 'marker','.');
axis tight