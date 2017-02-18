% visualize three features in a 3-D space

% function Visualize_model_3D(fileName, f1, f2, f3)



clc;close all;
OutIndex=40;
fileName=['C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\IIITDemo\Models\human_dog_model',int2str(OutIndex),'.txt'];%,int2str(OutIndex)
f1 = 1;
f2 = 11;
f3 = 12;

[SV_matlab, param, gamma, rho]=Model2Matrix(fileName,18);

nPoint = length(param);
nPositiveSVs = length(find(param>0));

% nNegativeSVs = size(SV_matlab,1)-nPositiveSVs;
% 
% point_positive = zeros(nPositiveSVs,3);
% point_negative = zeros(nNegativeSVs,3);
% for i=1:nPositiveSVs
%     point_positive(i,:) = SV_matlab(i,[f1 f2 f3]);
% end
% for i=1:nNegativeSVs
%     point_negative(i,:) = SV_matlab(i+nPositiveSVs,[f1 f2 f3]);
% end
plot3(SV_matlab(1:nPositiveSVs,f1),SV_matlab(1:nPositiveSVs,f2),SV_matlab(1:nPositiveSVs,f3),'r.');
hold on;
plot3(SV_matlab(nPositiveSVs+1:nPoint,f1),SV_matlab(nPositiveSVs+1:nPoint,f2),SV_matlab(nPositiveSVs+1:nPoint,f3),'b.');
hold off;
grid on;
legend('Dog SV','Human SV');
set(gca,'FontSize',14);
xlabel(['f',int2str(f1)],'FontSize', 18);
ylabel(['f',int2str(f2)],'FontSize', 18);
zlabel(['f',int2str(f3)],'FontSize', 18);

        