clc;
clear all;

numEnvs = [1 2 4 5 6 8 10];

top_10 = [14.6341 35.7724 84.5528 97.56 95.935 95.122 95.122];
%top_15 = [31.71 54.4715 88.6179 98.37 95.935 95.935 97.97];

h = gca;
plot(numEnvs, top_10, 'LineWidth', 3, 'Marker', 'x');
grid on
%hold on
%plot(numEnvs, top_15, 'LineWidth', 3, 'Marker', 'o');
% l=cell(1,2);
% l{1}='Top 10 Features'; l{2}='Top 15 Features';
% legend(l,'interpreter','latex','Location','SouthEast');
xlim([1 10]);
h.TickLabelInterpreter='latex';
%h.FontName = 'CMU Serif';
%h.Interpreter='latex';
h.FontWeight = 'bold';
h.FontSize = 20;
h.XLabel.String = 'No. of Training Envs.';
h.XLabel.Interpreter='latex';
h.XLabel.FontSize = 30;
%h.XLabel.FontName = 'CMU Serif';
h.XLabel.FontWeight = 'bold';

h.YLabel.String = 'Precision';
h.YLabel.Interpreter='latex';
h.YLabel.FontSize = 30;
%h.YLabel.FontName = 'CMU Serif';
h.YLabel.FontWeight = 'bold';
hold off

saveas(h, '../Images/matlab/precision/Saturation_manyEnvs.fig');
saveas(h, '../Images/matlab/precision/Saturation_manyEnvs.eps', 'eps2c');
