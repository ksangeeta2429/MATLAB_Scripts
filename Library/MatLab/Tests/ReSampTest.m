function ReSampTest;

N0 = 500;
N1 = 2*N0;

Test = randn(1,N0) + i*randn(1,N0);
TestUp = UpSamp(Test, N1);
TestRound = DownSamp(TestUp, N0);

Err = Test - TestRound;

subplot(2,1,1)
plot(log10(abs(Err)), '.')

subplot(2,1,2)
UnRot = UnWrap(angle(Err)/2/pi, -0.5,0.5);
plot(UnRot, '.')

disp(sprintf('Max = %f\nAvg = %f\n', max(abs(Err)), mean(abs(Err))))