function CreateRandomSplits(data,seed,folds,dest_folder)

if exist(dest_folder, 'dir') ~= 7
        mkdir(dest_folder); % Includes path_to_topk_arffs_scaled
        fprintf('INFO: created directory %s\n', dest_folder);
end
    
import weka.core.Instances;
import weka.core.Utils;
import weka.classifiers.Classifier;
import weka.classifiers.Evaluation;

import java.util.Random;

% Set class attribute
data.setClassIndex(data.numAttributes() - 1);

% Randomize data
rand = Random(seed);
randData = Instances(data);
randData.randomize(rand);
if randData.classAttribute().isNominal()
  randData.stratify(folds);
end

% Create and save partitions
for n=0:folds-1
    partition = randData.testCV(folds, n);
    saveARFF(strcat(dest_folder,'/partition-',num2str(n+1),'.arff'),partition);
end