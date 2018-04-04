function wekaClassifier = trainWekaClassifier(wekaData,type,options)

%wekaData=wekaobj_set;
%type='functions.SMOreg';
%options='weka.classifiers.functions.SMOreg -C 1.0 -N 0 -I "weka.classifiers.functions.supportVector.RegSMOImproved -L 0.0010 -W 1 -P 1.0E-12 -T 0.0010 -V" -K "weka.classifiers.functions.supportVector.Puk -C 250007 -O 1.0 -S 1.0"';


% Train a weka classifier.
%
% wekaData - A weka java Instances object holding all of the training data.
%            You can convert matlab data to this format via the
%            matlab2weka() function or load existing weka arff data using
%            the loadARFF() function. 
%
% type    -  A string naming the type of classifier to train relative to
%            the weka.classifiers package. There are many options - see
%            below for a few. See the weka documentation for the rest. 
%
% options - an optional cell array of strings listing the options specific
%           to the classifier. See the weka documentation for details. 
%
% Example: 
% wekaClassifier = trainWekaClassifier(data,'bayes.NaiveBayes',{'-D'});
%
% List of a few selected weka classifiers - there are many many more:
% 
% bayes.BayesNet
% bayes.NaiveBayes
% bayes.NaiveBayesMultinomial
% bayes.HNB
% functions.GaussianProcesses
% functions.IsotonicRegression
% functions.Logistic
% functions.MultilayerPerceptron
% functions.RBFNetwork
% functions.SVMreg
% lazy.IBk
% lazy.LBR
% misc.HyperPipes
% trees.RandomForest
% ...


import weka.core.Utils.splitOptions;
import weka.functions.supportVector.*;
if(~wekaPathCheck || isempty(wekaData)),wekaClassifier = []; return,end
wekaClassifier = javaObject(['weka.classifiers.',type]);
if(nargin == 3 && ~isempty(options))
    wekaClassifier.setOptions(weka.core.Utils.splitOptions(options));
end
wekaClassifier.buildClassifier(wekaData);
wekaClassifier
