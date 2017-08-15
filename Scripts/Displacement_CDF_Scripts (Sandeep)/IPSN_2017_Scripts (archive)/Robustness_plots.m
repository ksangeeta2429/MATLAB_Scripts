clc;
clear all;

features = [10 15 20 30 40];

% 1-combinations
infogain(1,:) = [31.729 20.917 26.408 17.772 43.083];
mRMR(1,:) = [53.538 41.224 51 27 59.837];

%mRMR_minEnvs(1,:) = [53.538 41.224 51 27 59.837];
mRMR_MAD(1,:) = [53.538 41.224 51 27 59.837];

% 2-combinations
infogain(2,:) = [62.58125 51.77025 48.51375 51.33075 40.90875];
mRMR(2,:) = [51.36425 47.8175 42.71375 51.33075 39.76175];

%mRMR_minEnvs(2,:) = [49.07025 47.6345 39.5285 41.99125 45.107];
mRMR_MAD(2,:) = [33.05175 29.511 28.113 28.579 24.63025];

% 3-combinations
infogain(3,:) = [50.6045 45.8515 45.70975 44.04875 44.80175];
mRMR(3,:) = [49.91975 42.71525 43.9445 35.471 37.6575];

%mRMR_minEnvs(3,:) = [50.78975 37.37325 36.58325 36.96625 30.0235];
mRMR_MAD(3,:) = [25.70925 31.09475 41.006 43.21975 29.317];

% 4-combinations
infogain(4,:) = [22.62625 42.21825 55.09975 59.40225 43.33925];
mRMR(4,:) = [58.229 42.82925 31.18225 29.80625 27.26675];

%mRMR_minEnvs(4,:) = [43.24275 39.19175 26.71075 26.4325 27.962];
mRMR_MAD(4,:) = [24.27175 33.717 35.05025 22.854 23.9035];

% 5-combinations
% infogain(5,:) = [22.89475 40.25 5.2455 29.9605 42.1815];
% mRMR(5,:) = [31.644 33.38775 8.62375 6.33625 17.332];
% 
% mRMR_minEnvs(5,:) = [51.15025 36.116 4.20725 22.36225 16.57825];
% mRMR_MAD(5,:) = [5.67825 12.0255 6.21725 3.678 12.23525];

perfs_top10_combs = [];
for i=1:4 % top-k
    perfs_top10_combs(i,1) = infogain(i,1);
    perfs_top10_combs(i,2) = mRMR(i,1);
    %perfs_top10_combs(i,3) = mRMR_minEnvs(i,1);
    perfs_top10_combs(i,3) = mRMR_MAD(i,1);
end

perfs_top15_combs = [];
for i=1:4 % top-k
    perfs_top15_combs(i,1) = infogain(i,2);
    perfs_top15_combs(i,2) = mRMR(i,2);
    %perfs_top15_combs(i,3) = mRMR_minEnvs(i,2);
    perfs_top15_combs(i,3) = mRMR_MAD(i,2);
end

perfs_top20_combs = [];
for i=1:4 % top-k
    perfs_top20_combs(i,1) = infogain(i,3);
    perfs_top20_combs(i,2) = mRMR(i,3);
    %perfs_top20_combs(i,3) = mRMR_minEnvs(i,3);
    perfs_top20_combs(i,3) = mRMR_MAD(i,3);
end

perfs_top30_combs = [];
for i=1:4 % top-k
    perfs_top30_combs(i,1) = infogain(i,4);
    perfs_top30_combs(i,2) = mRMR(i,4);
    %perfs_top30_combs(i,3) = mRMR_minEnvs(i,4);
    perfs_top30_combs(i,3) = mRMR_MAD(i,4);
end


% perfs_top40_combs = [];
% for i=1:5 % top-k
%     perfs_top40_combs(i,1) = infogain(i,5);
%     perfs_top40_combs(i,2) = mRMR(i,5);
%     perfs_top40_combs(i,3) = mRMR_minEnvs(i,5);
%     perfs_top40_combs(i,4) = mRMR_MAD(i,5);
% end

%% Plot
%Top-10
g = bar(perfs_top10_combs);
grid on
l=cell(1,3);
%l{1}='InfoGain'; l{2}='mRMR'; l{3}='minEnvs'; l{4}='MAD';
l{1}='InfoGain'; l{2}='mRMR'; l{3}='MAD';
legend(g,l, 'interpreter', 'latex');

h=gca;
h.TickLabelInterpreter='latex';
%h.FontName = 'CMU Serif';
%h.Interpreter='latex';
h.FontWeight = 'bold';
h.FontSize = 20;
h.XTickLabel={'1', '2', '3', '4'};
h.XLabel.String = 'No. of Env. Combos.';
h.XLabel.Interpreter='latex';
h.XLabel.FontSize = 30;
%h.XLabel.FontName = 'CMU Serif';
h.XLabel.FontWeight = 'bold';

h.YLabel.String = 'Precision IQR';
h.YLabel.Interpreter='latex';
h.YLabel.FontSize = 30;
%h.YLabel.FontName = 'CMU Serif';
h.YLabel.FontWeight = 'bold';
saveas(h, '../matlab/robustness/Rob_Top_10.fig');
saveas(h, '../matlab/robustness/Rob_Top_10.eps', 'eps2c');

%Top-15
g = bar(perfs_top15_combs);
grid on
l=cell(1,3);
%l{1}='InfoGain'; l{2}='mRMR'; l{3}='minEnvs'; l{4}='MAD';
l{1}='InfoGain'; l{2}='mRMR'; l{3}='MAD';
legend(g,l, 'interpreter', 'latex');

h=gca;
h.TickLabelInterpreter='latex';
%h.FontName = 'CMU Serif';
%h.Interpreter='latex';
h.FontWeight = 'bold';
h.FontSize = 20;
h.XTickLabel={'1', '2', '3', '4'};
h.XLabel.String = 'No. of Env. Combos.';
h.XLabel.Interpreter='latex';
h.XLabel.FontSize = 30;
%h.XLabel.FontName = 'CMU Serif';
h.XLabel.FontWeight = 'bold';

h.YLabel.String = 'Precision IQR';
h.YLabel.Interpreter='latex';
h.YLabel.FontSize = 30;
%h.YLabel.FontName = 'CMU Serif';
h.YLabel.FontWeight = 'bold';
saveas(h, '../matlab/robustness/Rob_Top_15.fig');
saveas(h, '../matlab/robustness/Rob_Top_15.eps', 'eps2c');

%Top-20
g = bar(perfs_top20_combs);
grid on
l=cell(1,3);
%l{1}='InfoGain'; l{2}='mRMR'; l{3}='minEnvs'; l{4}='MAD';
l{1}='InfoGain'; l{2}='mRMR'; l{3}='MAD';
legend(g,l, 'interpreter', 'latex');

h=gca;
h.TickLabelInterpreter='latex';
%h.FontName = 'CMU Serif';
%h.Interpreter='latex';
h.FontWeight = 'bold';
h.FontSize = 20;
h.XTickLabel={'1', '2', '3', '4'};
h.XLabel.String = 'No. of Env. Combos.';
h.XLabel.Interpreter='latex';
h.XLabel.FontSize = 30;
%h.XLabel.FontName = 'CMU Serif';
h.XLabel.FontWeight = 'bold';

h.YLabel.String = 'Precision IQR';
h.YLabel.Interpreter='latex';
h.YLabel.FontSize = 30;
%h.YLabel.FontName = 'CMU Serif';
h.YLabel.FontWeight = 'bold';
saveas(h, '../matlab/robustness/Rob_Top_20.fig');
saveas(h, '../matlab/robustness/Rob_Top_20.eps', 'eps2c');

%Top-30
g = bar(perfs_top30_combs);
grid on
l=cell(1,3);
%l{1}='InfoGain'; l{2}='mRMR'; l{3}='minEnvs'; l{4}='MAD';
l{1}='InfoGain'; l{2}='mRMR'; l{3}='MAD';
legend(g,l, 'interpreter', 'latex');

h=gca;
h.TickLabelInterpreter='latex';
%h.FontName = 'CMU Serif';
%h.Interpreter='latex';
h.FontWeight = 'bold';
h.FontSize = 20;
h.XTickLabel={'1', '2', '3', '4'};
h.XLabel.String = 'No. of Env. Combos.';
h.XLabel.Interpreter='latex';
h.XLabel.FontSize = 30;
%h.XLabel.FontName = 'CMU Serif';
h.XLabel.FontWeight = 'bold';

h.YLabel.String = 'Precision IQR';
h.YLabel.Interpreter='latex';
h.YLabel.FontSize = 30;
%h.YLabel.FontName = 'CMU Serif';
h.YLabel.FontWeight = 'bold';
saveas(h, '../matlab/robustness/Rob_Top_30.fig');
saveas(h, '../matlab/robustness/Rob_Top_30.eps', 'eps2c');

%Top-40
% g = bar(perfs_top40_combs);
% grid on
% l=cell(1,4);
% l{1}='InfoGain'; l{2}='mRMR'; l{3}='minEnvs'; l{4}='MAD';
% legend(g,l, 'interpreter', 'latex');
% 
% h=gca;
% h.TickLabelInterpreter='latex';
% %h.FontName = 'CMU Serif';
% %h.Interpreter='latex';
% h.FontWeight = 'bold';
% h.FontSize = 20;
% h.XTickLabel={'1', '2', '3', '4', '5'};
% h.XLabel.String = 'No. of Env. Combos.';
% h.XLabel.Interpreter='latex';
% h.XLabel.FontSize = 30;
% %h.XLabel.FontName = 'CMU Serif';
% h.XLabel.FontWeight = 'bold';
% 
% h.YLabel.String = 'Precision IQR';
% h.YLabel.Interpreter='latex';
% h.YLabel.FontSize = 30;
% %h.YLabel.FontName = 'CMU Serif';
% h.YLabel.FontWeight = 'bold';
% saveas(h, '../matlab/robustness/Rob_Top_40.fig');
% saveas(h, '../matlab/robustness/Rob_Top_40.eps', 'eps2c');