clc;
clear all;

perfs(1,:) = [77.235 97.56]; %[top 15 similar   top 10 different]
perfs(2,:) = [90.86 98.37];  %[top 15 similar   top 10 different]

%% Plot
%Top-10
g = bar(perfs);
grid on
l=cell(1,2);
l{1}='Similar Envs'; l{2}='Different Envs';
legend(g,l,'interpreter','latex', 'Location', 'SouthEast');

h=gca;
h.TickLabelInterpreter='latex';
%h.FontName = 'CMU Serif';
%h.Interpreter='latex';
h.FontWeight = 'bold';
h.FontSize = 20;
h.XTickLabel={'Top 10', 'Top 15'};
h.XLabel.String = 'No. of Features';
h.XLabel.Interpreter='latex';
h.XLabel.FontSize = 30;
%h.XLabel.FontName = 'CMU Serif';
h.XLabel.FontWeight = 'bold';

h.YLabel.String = 'Precision (\%)';
h.YLabel.Interpreter='latex';
h.YLabel.FontSize = 30;
%h.YLabel.FontName = 'CMU Serif';
h.YLabel.FontWeight = 'bold';
saveas(h, '../matlab/precision/Diversity_is_better.fig');
saveas(h, '../matlab/precision/Diversity_is_better.eps', 'eps2c');


































hold off