%% Read Data
[I1,Q1] = ReadBinComp('09-03-02\step-1ft.data');
[I2,Q2] = ReadBinComp('09-03-02\step-2ft.data');
[I3,Q3] = ReadBinComp('09-03-02\step-3ft.data');

Rate = 1024/3;

N1 = length(I1);
Time1 = [0 : N1-1] / Rate;

N2 = length(I2);
Time2 = [0 : N2-1] / Rate;

N3 = length(I3);
Time3 = [0 : N3-1] / Rate;

Comp1 = I1 + i*Q1;
Comp2 = I2 + i*Q2;
Comp3 = I3 + i*Q3;

%% Spectragrams
Index = ((20 < Time1) & (Time1 < 80));

figure(1)
spectrogram(Comp1(Index), 256,256-32,256,1024/3)
title('1 Foot Stride')
SaveFigure('Spec 1ft', 5.5,8, '-dmeta', [0.7,0.6,0.4,0.2])

figure(2)
spectrogram(Comp2(Index), 256,256-32,256,1024/3)
title('2 Foot Stride')
SaveFigure('Spec 2ft', 5.5,8, '-dmeta', [0.7,0.6,0.4,0.2])

figure(3)
spectrogram(Comp3(Index), 256,256-32,256,1024/3)
title('3 Foot Stride')
SaveFigure('Spec 3ft', 5.5,8, '-dmeta', [0.7,0.6,0.4,0.2])

%% Writing data
Max1 = max(max(I1(Index)), max(Q1(Index)));
Max2 = max(max(I2(Index)), max(Q2(Index)));
Max3 = max(max(I3(Index)), max(Q3(Index)));

wavwrite([I1(Index),Q1(Index)]/Max1, round(Rate),16, 'Raw 1ft')
wavwrite([I2(Index),Q2(Index)]/Max2, round(Rate),16, 'Raw 2ft')
wavwrite([I3(Index),Q3(Index)]/Max3, round(Rate),16, 'Raw 3ft')