clc;
clear all;

features = [10 20 30 40 50 60];

infogain_similar = [44.57675 34.70585 33.752 37.6782 37.6782 63.555];
infogain_different = [64.46225 83.6675 85.69775 77.9425 72.511 74.77275];

mrmr_similar = [38.3656 52.73475 50.18925 47.09653333 47.09653333 60.495];
mrmr_different = [78.5335 65.3415 72.66875 72.18125 72.46325 74.77275];

h = gca;
plot(features, infogain_similar, 'LineWidth', 3, 'Marker', 'x', 'DisplayName', 'Similar environments');
grid on
hold on

plot(features, infogain_different, 'LineWidth', 3, 'Marker', 'o', 'DisplayName', 'Different environments');
legend('show')

h.FontName = 'Times New Roman';
h.FontWeight = 'bold';
h.FontSize = 20;

h.XLabel.String = 'Number of Features';
h.XLabel.FontSize = 30;
h.XLabel.FontName = 'Times New Roman';
h.XLabel.FontWeight = 'bold';

h.YLabel.String = 'Accuracy (%)';
h.YLabel.FontSize = 30;
h.YLabel.FontName = 'Times New Roman';
h.YLabel.FontWeight = 'bold';
hold off

saveas(h, '../matlab/InfoGain_diff_vs_similar.fig');
saveas(h, '../matlab/InfoGain_diff_vs_similar.eps', 'eps2c');
% print('../matlab/InfoGain_diff_vs_similar','-depsc')

figure
g = gca;
plot(features, mrmr_similar, 'LineWidth', 3, 'Marker', '*', 'DisplayName', 'Similar environments');
grid
hold on

plot(features, mrmr_different, 'LineWidth', 3, 'Marker', '+', 'DisplayName', 'Different environments');
legend('show')

g.FontName = 'Times New Roman';
g.FontWeight = 'bold';
g.FontSize = 20;

g.XLabel.String = 'Number of Features';
g.XLabel.FontSize = 30;
g.XLabel.FontName = 'Times New Roman';
g.XLabel.FontWeight = 'bold';

g.YLabel.String = 'Accuracy (%)';
g.YLabel.FontSize = 30;
g.YLabel.FontName = 'Times New Roman';
g.YLabel.FontWeight = 'bold';
hold off

saveas(g, '../matlab/mRMR_diff_vs_similar.fig');
% saveas(g, '../matlab/mRMR_diff_vs_similar.eps');
print('../matlab/mRMR_diff_vs_similar','-depsc')


































hold off