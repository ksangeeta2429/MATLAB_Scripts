N=1;
IQRejectionParam=0.9;

h0=WalkCdfs_Individual_MASS("/mnt/6b93b438-a3d4-40d2-9f3d-d8cdbb850183/Research/Robust_Learning/Data_Repository/IPSNdata/bv_4/Dog",'/mnt/6b93b438-a3d4-40d2-9f3d-d8cdbb850183/Research/Robust_Learning/Results/Displacement_Graphs/Walk_CDFs/','PRB',250,0.9,N);
h1=WalkCdfs_Individual_MASS("/mnt/6b93b438-a3d4-40d2-9f3d-d8cdbb850183/Research/Robust_Learning/Data_Repository/IPSNdata/5-15-2011/Dog",'/mnt/6b93b438-a3d4-40d2-9f3d-d8cdbb850183/Research/Robust_Learning/Results/Displacement_Graphs/Walk_CDFs/','PRB',250,0.9,N);
h2=WalkCdfs_Individual_MASS("/mnt/6b93b438-a3d4-40d2-9f3d-d8cdbb850183/Research/Robust_Learning/Data_Repository/IPSNdata/5-16-2011/Dog",'/mnt/6b93b438-a3d4-40d2-9f3d-d8cdbb850183/Research/Robust_Learning/Results/Displacement_Graphs/Walk_CDFs/','PRB',250,0.9,N);

h=gca;
h.XLabel.String = 'Distance (meters)';
h.YLabel.String = 'CCDF';
xlim([0 1]);
legend([h0 h1 h2],{'Knowlton','5-15-2011','5-16-2011'});
title(sprintf('Car CDFs for\n%d 1/2-second Windows(IQR Parameter=%0.2f)',N,IQRejectionParam),'FontWeight','normal');
xlim([0 0.6]);

saveas(h,strcat('/mnt/6b93b438-a3d4-40d2-9f3d-d8cdbb850183/Research/Robust_Learning/Results/Displacement_Graphs/Graphs/Car_CDFs_N=',num2str(N),'_IQR=',num2str(IQRejectionParam),'.fig'));
saveas(h,strcat('/mnt/6b93b438-a3d4-40d2-9f3d-d8cdbb850183/Research/Robust_Learning/Results/Displacement_Graphs/Graphs/Car_CDFs_N=',num2str(N),'_IQR=',num2str(IQRejectionParam),'.eps'),'eps2c');

