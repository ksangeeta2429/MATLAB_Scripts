% visualize three features in a 2-D space

% function Visualize_model_2D(fileName, f1, f2)



clc;close all;
OutIndex=245;
fileName=['C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\IIITDemo\Models\human_dog_model',int2str(OutIndex),'.txt'];%,int2str(OutIndex)
f1 = 19;
f2 = 21;
nFeature = 60;

[SV_matlab, param, gamma, rho]=Model2Matrix(fileName,nFeature);

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

% for f1=1:18
%     for f2=1:18
%         if f1<f2 && f1~=16 && f1~=18 && f2~=16 && f2~=18
            plot(SV_matlab(1:nPositiveSVs,f1),SV_matlab(1:nPositiveSVs,f2),'r.');
            hold on;
            plot(SV_matlab(nPositiveSVs+1:nPoint,f1),SV_matlab(nPositiveSVs+1:nPoint,f2),'b.');
            hold off;
            grid on;
            legend('Dog SV','Human SV');
            set(gca,'FontSize',14);
            xlabel(['f',int2str(f1)],'FontSize', 18);
            ylabel(['f',int2str(f2)],'FontSize', 18);
            pause(0.5);
%         end
%     end
% end




        