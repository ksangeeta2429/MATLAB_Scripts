function NoiseCheck(N,Level)

ReDC = 2048 + 15*randn(1);
ImDC = 2048 + 15*randn(1);

R = Level * randn(1,N) + ReDC;
I = Level * randn(1,N) + ImDC;
Rate = 250;

TestFreq(R,I, Rate)