%% Example file of how to use Weka's regression functions in Matlab
%% Loads Weka, selects a dataset, uses SMORegression, and evaluates the results
%% against a testset (by manually iterating over the instances, rather
%% than using one of the evaluation tools)
%% It also creates a couple of instances not in the testfile. 

%% FIRST LOAD WEKA
wekaHome = getenv('WEKA_HOME');
wekaJar = sprintf('%s/weka.jar',wekaHome);
if ~exist(wekaJar,'file')
  error(sprintf('File %s not found',wekaJar));
end
javaaddpath(sprintf('%s/weka.jar',wekaHome));
import weka.core.Instances.*
import weka.classifiers.functions.supportVector.*
import weka.core.converters.ConverterUtils$DataSource.*

%% LOAD A DATA FILE
%% This file is of the form (x,y,...,z,f(x,y,...,z)). All attributes numerical.
%% First line contains attribute names
%% Don't use "~" in the path -- it confuses java
trainFilename = 'traindata.csv';
if ~exist(trainFilename,'file')
  error(sprintf('File %s not found',trainFilename));
end
source = javaObject('weka.core.converters.ConverterUtils$DataSource',trainFilename);
trainData = source.getDataSet();
if (trainData.classIndex() == -1) % -1 means that it is undefined
    trainData.setClassIndex(trainData.numAttributes() - 1);
end

%% SELECT THE SVM REGRESSION TOOL
%% svmReg.getOptions() will tell you what the default values are
%% methods(svmReg) will tell you what functions are available
svmReg = weka.classifiers.functions.SMOreg();     
  svmReg.setC(1.0);

%% SELECT THE OPTIMIZER
r = weka.classifiers.functions.supportVector.RegSMOImproved();
    % -L epsilon. default = 1.0e-3
    % -W rand seed. default = 1
    % -P precision. default = 1.0e-12
    % -T tolerance. default = 0.0010
    % -V variant. true=1 else 2
    % CAN USE THE setOptions METHOD OR SPECIFIC FUNCTIONS LIKE setSeed and
    % setEpsilon. Use "methods(r)" to see what they are
    w(1) = java.lang.String('-L');
    w(2) = java.lang.String(sprintf('%f',0.0010));
    ropts = cat(1,w(1:end));
    r.setOptions(ropts);
    r.setUseVariant1(true);
svmReg.setRegOptimizer(r);    

%% SELECT THE PUK KERNEL
kernel = weka.classifiers.functions.supportVector.Puk();
    kernel.setOmega(1.0);
    kernel.setSigma(1.0);
svmReg.setKernel(kernel);  

%% NOW BUILD THE SVM
svmReg.buildClassifier(trainData);

%% EVALUATE THE SVM BY MANUALLY EXAMINING THE INSTANCES
%% We expect the true value to be in this file too.
testFilename = 'testdata.csv';
if ~exist(testFilename,'file')
  error(sprintf('File %s not found',testFilename));
end
source = javaObject('weka.core.converters.ConverterUtils$DataSource',testFilename);
testData = source.getDataSet();

numInst = testData.numInstances;
for i=1:numInst
  values(i) = svmReg.classifyInstance(testData.instance(i-1));
end
for i=1:numInst
  inst = testData.instance(i-1); % i-1 because java uses zero-indexed arrays
  vals = inst.toDoubleArray();
  diff=vals(end)-values(i);
  fprintf('%d. Actual=%.1f Predicted=%.1f Difference=%.1f\n',i, vals(end),values(i),diff)
end

%% JUST FOR FUN, CREATE AN INSTANCE OUT OF WEIRD VALUES
numAttribs =testData.numAttributes;
minVals = Inf * ones(numAttribs,1);
maxVals = -Inf * ones(numAttribs,1);
for i=1:numInst
  inst = testData.instance(i-1); % i-1 because java uses zero-indexed arrays
  vals = inst.toDoubleArray();
  minVals = min( minVals, vals );
  maxVals = max( maxVals, vals );
end
%% MINIMUMS
for i=1:numAttribs
  inst.setValue( i-1, minVals(i) ); %% i-1 because java uses zero-indexed arrays
end
fprintf('Min. ');
fprintf('%.1f,',minVals); %% Print each value in the instance
fprintf(' ==> %.1f\n',svmReg.classifyInstance(inst));
%% MAXIMUMS
for i=1:numAttribs
  inst.setValue( i-1, maxVals(i) ); %% i-1 because java uses zero-indexed arrays
end
fprintf('Max. ');
fprintf('%.1f,',maxVals); %% Print each value in the instance
fprintf(' ==> %.1f\n',svmReg.classifyInstance(inst));
