N=1;
IQRejectionParam=0.9;

h0=WalkCdfs_Individual_MASS('/media/mydrive/Robust_Learning/Data_Repository/IPSNdata/arc_1/Dog','/media/mydrive/Robust_Learning/Results/Displacement_Graphs/Walk_CDFs/','PRB',250,0.9,N);
h1=WalkCdfs_Individual_MASS('/media/mydrive/Robust_Learning/Data_Repository/IPSNdata/prb_2/Dog','/media/mydrive/Robust_Learning/Results/Displacement_Graphs/Walk_CDFs/','PRB',250,0.9,N);
h2=WalkCdfs_Individual_MASS('/media/mydrive/Robust_Learning/Data_Repository/IPSNdata/kh_3/Dog','/media/mydrive/Robust_Learning/Results/Displacement_Graphs/Walk_CDFs/','ortho_7m',250,0.9,N);

h=gca;
h.XLabel.String = 'Distance (meters)';
h.YLabel.String = 'CDF';
xlim([0 1]);
legend([h0 h1 h2],{'ARC','PRB','Knowlton'});
title(sprintf('Ball CDFs for\n%d 1/2-second Windows(IQR Parameter=%0.2f)',N,IQRejectionParam),'FontWeight','normal');
xlim([0 0.6]);

saveas(h,strcat('/media/mydrive/Robust_Learning/Results/Displacement_Graphs/Graphs/Ball_CDFs_N=',num2str(N),'_IQR=',num2str(IQRejectionParam),'.fig'));
saveas(h,strcat('/media/mydrive/Robust_Learning/Results/Displacement_Graphs/Graphs/Ball_CDFs_N=',num2str(N),'_IQR=',num2str(IQRejectionParam),'.eps'),'eps2c');

