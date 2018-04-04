%used for matlab embedded svm: svmtrain

%function Crossval_matlab(OutIndex)
OutIndex=11;
ifReg==0;

%instances = loadARFF(sprintf('../arff files/radar%d.arff',OutIndex));
% if ifReg==1
%     [f_set, featureNames]=weka2matlab(instances,[]);
% else 
%     [f_set, featureNames]=weka2matlab(instances,{});
% end


load(sprintf('../arff files/radar%d.mat',OutIndex),'f_set');

if ifReg==0
    data=cell2mat(f_set(:,1:size(f_set,2)-1));
else %ifReg==1
    data=f_set(:,1:size(f_set,2)-1);
end
groups=f_set(:,size(f_set,2));

SVMstruct = svmtrain(data,groups,'Kernel_Function','rbf');
c = cvpartition(size(f_set,1),'kfold',10)
    C = cvpartition(GROUP,'Kfold',10)


 load('fisheriris');
      CVO = cvpartition(species,'k',10);
      err = zeros(CVO.NumTestSets,1);
      for i = 1:CVO.NumTestSets
          trIdx = CVO.training(i);
          teIdx = CVO.test(i);
          ytest = classify(meas(teIdx,:),meas(trIdx,:),species(trIdx,:));
          err(i) = sum(~strcmp(ytest,species(teIdx)));
      end
      cvErr = sum(err)/sum(CVO.TestSize);


[svm_struct, svIndex] = svmtrain(training, groupnames, varargin)