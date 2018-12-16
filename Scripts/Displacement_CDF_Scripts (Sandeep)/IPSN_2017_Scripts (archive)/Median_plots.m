clc;
clear all;

features = [10 15 20 30 40];

% 1-combinations
infogain(1,:) = [54.4045 76.2545 75.043 63.1625 62.2915];
mRMR(1,:) = [60.361 59.458 73.846 65.9865 66.3885];

%mRMR_minEnvs(1,:) = [60.361 59.458 73.846 65.9865 66.3885];
mRMR_MAD(1,:) = [60.361 59.458 73.846 65.9865 66.3885];

% 2-combinations
infogain(2,:) = [62.5 61.841 65 60.363 68.0275];
mRMR(2,:) = [69.069 73.222 71.3795 75.037 79.0065];

%mRMR_minEnvs(2,:) = [65.494 74.7865 78.625 79.0065 73.071];
mRMR_MAD(2,:) = [72.997 75.907 75.778 78.125 84.684];

% 3-combinations
infogain(3,:) = [60.3025 64.103 68.9905 76.2965 74.9615];
mRMR(3,:) = [66.4445 79.2735 76.2165 76.5535 76.7755];

%mRMR_minEnvs(3,:) = [70 75.755 73.273 83.503 83.9755];
mRMR_MAD(3,:) = [73.273 81.0095 77.4305 82.1625 80.7485];

% 4-combinations
infogain(4,:) = [69.229 75.796 69.2505 76.755 78];
mRMR(4,:) = [70.833 82.2915 73.755 80.7485 81.4415];

%mRMR_minEnvs(4,:) = [74.2345 74.4895 84.861 84.375 89.583];
mRMR_MAD(4,:) = [78.359 87.6275 77.6645 83.812 79.5835];

% 5-combinations
% infogain(5,:) = [78.4445 68.403 83.124 77.796 73.9565];
% mRMR(5,:) = [66.5835 83.0555 88.669 85.079 79.302];
% 
% mRMR_minEnvs(5,:) = [67.694 85.898 87.211 84.609 93.875];
% mRMR_MAD(5,:) = [78.5835 87.6275 79.5835 92.9135 82.577];

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
% for i=1:4 % top-k
%     perfs_top40_combs(i,1) = infogain(i,5);
%     perfs_top40_combs(i,2) = mRMR(i,5);
%     %perfs_top40_combs(i,3) = mRMR_minEnvs(i,5);
%     perfs_top40_combs(i,3) = mRMR_MAD(i,5);
% end

%% Plot
%Top-10
g = bar(perfs_top10_combs);
grid on
l=cell(1,3);
% l{1}='InfoGain'; l{2}='mRMR'; l{3}='minEnvs'; l{4}='MAD';
l{1}='InfoGain'; l{2}='mRMR'; l{3}='MAD';
legend(g,l,'Location','NorthWest','interpreter','latex');

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

h.YLabel.String = 'Median Precision (\%)';
h.YLabel.Interpreter='latex';
h.YLabel.FontSize = 30;
%h.YLabel.FontName = 'CMU Serif';
h.YLabel.FontWeight = 'bold';
saveas(h, '../matlab/precision/Prec_Top_10.fig');
saveas(h, '../matlab/precision/Prec_Top_10.eps', 'eps2c');

%Top-15
g = bar(perfs_top15_combs);
grid on
l=cell(1,3);
% l{1}='InfoGain'; l{2}='mRMR'; l{3}='minEnvs'; l{4}='MAD';
l{1}='InfoGain'; l{2}='mRMR'; l{3}='MAD';
legend(g,l,'Location','NorthWest','interpreter','latex');

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

h.YLabel.String = 'Median Precision (\%)';
h.YLabel.Interpreter='latex';
h.YLabel.FontSize = 30;
%h.YLabel.FontName = 'CMU Serif';
h.YLabel.FontWeight = 'bold';
saveas(h, '../matlab/precision/Prec_Top_15.fig');
saveas(h, '../matlab/precision/Prec_Top_15.eps', 'eps2c');

%Top-20
g = bar(perfs_top20_combs);
grid on
l=cell(1,3);
% l{1}='InfoGain'; l{2}='mRMR'; l{3}='minEnvs'; l{4}='MAD';
l{1}='InfoGain'; l{2}='mRMR'; l{3}='MAD';
legend(g,l,'Location','NorthWest','interpreter','latex');

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

h.YLabel.String = 'Median Precision (\%)';
h.YLabel.Interpreter='latex';
h.YLabel.FontSize = 30;
%h.YLabel.FontName = 'CMU Serif';
h.YLabel.FontWeight = 'bold';
saveas(h, '../matlab/precision/Prec_Top_20.fig');
saveas(h, '../matlab/precision/Prec_Top_20.eps', 'eps2c');

%Top-30
g = bar(perfs_top30_combs);
grid on
l=cell(1,3);
% l{1}='InfoGain'; l{2}='mRMR'; l{3}='minEnvs'; l{4}='MAD';
l{1}='InfoGain'; l{2}='mRMR'; l{3}='MAD';
legend(g,l,'Location','NorthWest','interpreter','latex');

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

h.YLabel.String = 'Median Precision (\%)';
h.YLabel.Interpreter='latex';
h.YLabel.FontSize = 30;
%h.YLabel.FontName = 'CMU Serif';
h.YLabel.FontWeight = 'bold';
saveas(h, '../matlab/precision/Prec_Top_30.fig');
saveas(h, '../matlab/precision/Prec_Top_30.eps', 'eps2c');

%Top-40
% g = bar(perfs_top40_combs);
% grid on
% l=cell(1,4);
% l{1}='InfoGain'; l{2}='mRMR'; l{3}='minEnvs'; l{4}='MAD';
% legend(g,l,'Location','NorthWest','interpreter','latex');
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
% h.YLabel.String = 'Median Precision (\%)';
% h.YLabel.Interpreter='latex';
% h.YLabel.FontSize = 30;
% %h.YLabel.FontName = 'CMU Serif';
% h.YLabel.FontWeight = 'bold';
% saveas(h, '../matlab/precision/Prec_Top_40.fig');
% saveas(h, '../matlab/precision/Prec_Top_40.eps', 'eps2c');