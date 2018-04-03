% data found in framelength.xls in \featuredescription
clc;close all;

frameLength = [20
30
40
60
80
90
100
120
140
160
200
];
corrCoef = [0.9056
0.9199
0.9397
0.9419
0.9594
0.9472
0.9491
0.9612
0.9574
0.9686
0.9646
];
meanAbbsErr = [3.7013
3.4432
3.0462
2.8905
2.4527
2.7566
2.67 
2.347
2.5037
2.1691
2.2764
];

plot(frameLength, corrCoef,'*-');
axis([0,210,0.9,1]);
xlabel('Frame Length (seconds)','FontSize',18);
ylabel('Correlation Coefficient','FontSize',18);
set(gca,'FontSize',14);

figure;
plot(frameLength, meanAbbsErr,'*-');
axis([0,210,2,4]);
xlabel('Frame Length (seconds)','FontSize',18);
ylabel('Mean Absolute Error','FontSize',18);
set(gca,'FontSize',14);