close all

IQRejectionParam = 0.9;

out_cornfield = ComputeNoiseCDFs_MASS('/media/mydrive/Robust_Learning/Data_Repository/Parking garage radial ortho (Sandeep)/SenSys10_data_scripts/data/1-CornField-Snow/snow-no-targets.data', ...
    '/media/mydrive/Robust_Learning/Results/Displacement_Graphs/Noise_CDFs/','snow-no-targets', 250, 0.5, IQRejectionParam);
out_garage = ComputeNoiseCDFs_MASS('/media/mydrive/Robust_Learning/Data_Repository/Parking garage radial ortho (Sandeep)/SenSys10_data_scripts/data/4-OSU-Garage/r46-garage.data', ...
    '/media/mydrive/Robust_Learning/Results/Displacement_Graphs/Noise_CDFs/', 'r46-garage', 250, 0.5, IQRejectionParam);
out_trees = ComputeNoiseCDFs_MASS('/media/mydrive/Robust_Learning/Data_Repository/Parking garage radial ortho (Sandeep)/SenSys10_data_scripts/data/3-AveryPark-2trees/r46-2trees-3m.data', ...
    '/media/mydrive/Robust_Learning/Results/Displacement_Graphs/Noise_CDFs/', 'r46-2trees-3m', 250, 0.5, IQRejectionParam);
out_bushes = ComputeNoiseCDFs_MASS('/media/mydrive/Robust_Learning/Data_Repository/Parking garage radial ortho (Sandeep)/SenSys10_data_scripts/data/2-CoffmanPark-Tree/Coffman-tree-2m.data', ...
    '/media/mydrive/Robust_Learning/Results/Displacement_Graphs/Noise_CDFs/', 'Coffman-tree-2m', 250, 0.5, IQRejectionParam);

h1=PlotCdfs_MASS(out_cornfield,'-');
h2=PlotCdfs_MASS(out_garage,'-');
h3=PlotCdfs_MASS(out_trees,'-');
h4=PlotCdfs_MASS(out_bushes,'-');

%% 3-second window thresholds
% fplot(@(x) -12.25,[0 0.5],'-k') % 1 false alarm per week
% fplot(@(x) -13.75,[0 0.5],'-k') % 1 false alarm per month
% fplot(@(x) -16.25,[0 0.5],'-k') % 1 false alarm per year

%% 1/2-second window thresholds
fplot(@(x) -14.01,[0 0.5],'-k'); % 1 false alarm per week
fplot(@(x) -15.47,[0 0.5],'--k'); % 1 false alarm per month
fplot(@(x) -17.96,[0 0.5],':k'); % 1 false alarm per year

annotation('textbox',...
    [0.753571428571429 0.339523808711155 0.162500002904046 0.0642857150983691],...
    'String','1 FA/week',...
    'LineStyle','none');
annotation('textbox',...
    [0.751785714285714 0.235238094425441 0.17678571747658 0.0642857150983691],...
    'String','1 FA/month',...
    'LineStyle','none');
annotation('textbox',...
    [0.753571428571429 0.133333332520679 0.153571431296212 0.0642857150983691],...
    'String','1 FA/year',...
    'LineStyle','none');

h = gca;
%l=cell(1,8);
%l{1}='Empty Mowed Field'; l{2}='Parking Garage'; l{3}='Trees (High Wind)'; l{4}='Bushes (light Wind)';
%legend(l,'interpreter','latex','Location','NorthEast');
legend([h1 h2 h3 h4],{'Empty Mowed Field','Parking Garage','Trees (High Wind)','Bushes (light Wind)'});

%h.TickLabelInterpreter='latex';
%h.FontWeight = 'bold';
%h.FontSize = 20;
h.XLabel.String = 'Distance (meters)';
%h.XLabel.Interpreter='latex';
%h.XLabel.FontSize = 20;
%h.XLabel.FontWeight = 'bold';

h.YLabel.String = 'log(False Alarm Probability)';
%h.YLabel.Interpreter='latex';
%h.YLabel.FontSize = 20;
%h.YLabel.FontWeight = 'bold';
title(sprintf('Noise CDFs and Thresholds for\nVarious False Alarm Rates (IQR Parameter=%0.2f)',IQRejectionParam),'FontWeight','normal');

saveas(h,strcat('/media/mydrive/Robust_Learning/Results/Displacement_Graphs/Graphs/NoiseCDFs_IQR=',num2str(IQRejectionParam),'.fig'));
saveas(h,strcat('/media/mydrive/Robust_Learning/Results/Displacement_Graphs/Graphs/NoiseCDFs_IQR=',num2str(IQRejectionParam),'.eps'),'eps2c');