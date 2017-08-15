out_cornfield = ComputeNoiseCDFs_MASS('/media/mydrive/Robust_Learning/Data_Repository/Parking garage radial ortho (Sandeep)/SenSys10_data_scripts/data/1-CornField-Snow/snow-no-targets.data', ...
    '/media/mydrive/Robust_Learning/Data_Repository/Parking garage radial ortho (Sandeep)/SenSys10_data_scripts/data/1-CornField-Snow/','snow-no-targets', 250, 0.5, 0.9);
out_garage = ComputeNoiseCDFs_MASS('/media/mydrive/Robust_Learning/Data_Repository/Parking garage radial ortho (Sandeep)/SenSys10_data_scripts/data/4-OSU-Garage/r46-garage.data', ...
    '/media/mydrive/Robust_Learning/Data_Repository/Parking garage radial ortho (Sandeep)/SenSys10_data_scripts/data/4-OSU-Garage/', 'r46-garage', 250, 0.5, 0.9);
out_trees = ComputeNoiseCDFs_MASS('/media/mydrive/Robust_Learning/Data_Repository/Parking garage radial ortho (Sandeep)/SenSys10_data_scripts/data/3-AveryPark-2trees/r46-2trees-3m.data', ...
    '/media/mydrive/Robust_Learning/Data_Repository/Parking garage radial ortho (Sandeep)/SenSys10_data_scripts/data/3-AveryPark-2trees/', 'r46-2trees-3m', 250, 0.5, 0.9);
out_bushes = ComputeNoiseCDFs_MASS('/media/mydrive/Robust_Learning/Data_Repository/Parking garage radial ortho (Sandeep)/SenSys10_data_scripts/data/2-CoffmanPark-Tree/Coffman-tree-2m.data', ...
    '/media/mydrive/Robust_Learning/Data_Repository/Parking garage radial ortho (Sandeep)/SenSys10_data_scripts/data/2-CoffmanPark-Tree/', 'Coffman-tree-2m', 250, 0.5, 0.9);

h1=PlotCdfs_MASS(out_cornfield,'-');
h2=PlotCdfs_MASS(out_garage,'-');
h3=PlotCdfs_MASS(out_trees,'-');
h4=PlotCdfs_MASS(out_bushes,'-');

fplot(@(x) -12.25,[0 0.5],'-k')
fplot(@(x) -13.75,[0 0.5],'-k')
fplot(@(x) -16.25,[0 0.5],'-k')

%h = gca;
%l=cell(1,8);
%l{1}='Cornfield'; l{2}='Line1'; l{3}='Parking Garage'; l{4}='Line2'; l{5}='Trees (High Wind)'; l{6}='Line3'; l{8}='Bushes (light Wind)'; l{7}='Line4';
% legend([h1 h2 h3 h4], 'Cornfield', 'Garage', 'Bush (Low noise)', 'Trees (High Noise', 'interpreter','latex','Location','NorthEast');
% 
% h.TickLabelInterpreter='latex';
% h.FontWeight = 'bold';
% h.FontSize = 20;
% h.XLabel.String = 'Distance (meters)';
% h.XLabel.Interpreter='latex';
% h.XLabel.FontSize = 20;
% h.XLabel.FontWeight = 'bold';
% 
% h.YLabel.String = 'log(False Alarm Probability)';
% h.YLabel.Interpreter='latex';
% h.YLabel.FontSize = 20;
% h.YLabel.FontWeight = 'bold';
% 
% 
% 
% 
% 
% 
% 
% 
% h1=PlotCdfs_MASS('C:\Users\royd\Desktop\IPSN_NoiseData\r46-Cornfield_noIQ-cdf-3.data','r','-');
% h2=PlotCdfs_MASS('C:\Users\royd\Desktop\IPSN_NoiseData\r46-garage_noIQ-cdf-3.data','b','-');
% h3=PlotCdfs_MASS('C:\Users\royd\Desktop\IPSN_NoiseData\r46-Avery_noIQ-cdf-3.data','k','-');
% h4=PlotCdfs_MASS('C:\Users\royd\Desktop\IPSN_NoiseData\r46-coffman_noIQ-cdf-3.data','g','-');
% 
% fplot(@(x) -12.25,[0 3],'-k')
% fplot(@(x) -13.75,[0 3],'-k')
% fplot(@(x) -16.25,[0 3],'-k')

h = gca;
l=cell(1,4);
l{1}='Empty Mowed Field'; l{2}='Parking Garage'; l{3}='Trees (High Wind)'; l{4}='Bushes (light Wind)';
legend(l,'interpreter','latex','Location','NorthEast');

h.TickLabelInterpreter='latex';
h.FontWeight = 'bold';
h.FontSize = 20;
h.XLabel.String = 'Distance (meters)';
h.XLabel.Interpreter='latex';
h.XLabel.FontSize = 20;
h.XLabel.FontWeight = 'bold';

h.YLabel.String = 'log(False Alarm Probability)';
h.YLabel.Interpreter='latex';
h.YLabel.FontSize = 20;
h.YLabel.FontWeight = 'bold';