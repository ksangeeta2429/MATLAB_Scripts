%function PredictRealData()

root='C:/Documents and Settings/he/My Documents/Dropbox/MyMatlabWork/';
addpath([root,'radar/STC/scripts/matlab2weka']);
addpath([root,'radar/STC/scripts']);

%%%%%%%%%%%%%%%%%% build model %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
OutIndex_train=7;
ifReg=1;

import weka.classifiers.Evaluation;
import weka.core.Utils.splitOptions;
import weka.functions.supportVector.*;
import weka.core.Instance; 


if ifReg==0
    type='functions.SMO';
    options='-C 1.0 -L 0.0010 -P 1.0E-12 -N 0 -V -1 -W 1 -K "weka.classifiers.functions.supportVector.Puk -C 250007 -O 1.0 -S 1.0"';
else  % ifReg=1
    type='functions.SMOreg';
    options='-C 1.0 -N 0 -I "weka.classifiers.functions.supportVector.RegSMOImproved -L 0.0010 -W 1 -P 1.0E-12 -T 0.0010 -V" -K "weka.classifiers.functions.supportVector.Puk -C 250007 -O 1.0 -S 1.0"';
end

path_arff=[root,'radar/STC/data files/arff files'];
cd(path_arff);
instances_train = loadARFF(sprintf('radar%d.arff',OutIndex_train));
classifier = javaObject(['weka.classifiers.',type]);
classifier.setOptions(weka.core.Utils.splitOptions(options));
classifier.buildClassifier(instances_train);

%%%%%%%%%%%%%%%%% real time collect data and predict  %%%%%%%%%%%%%%%%%%%
portNum=4;
if ~libisloaded('TrioSF')
    loadlibrary('TrioSF','MatLab.h')
end

portNum=calllib('TrioSF','init',portNum)  % Virutal COM port number for the Tmote, should be 6 for the currently using telosb

SampRate = 300;
PredictWindowSecs = 30;
Width = SampRate*PredictWindowSecs;

readarray = [1:4];
rp = libpointer('int16Ptr',readarray);

saveIndex=0;
dataSaved=zeros(2,Width);
while 1<2
    calllib('TrioSF','readVals',rp);
    result = get(rp,'Value');
    result = double(result);
    
    valid = result(1);
    cnt = result(2);
    chI = result(3);
    chQ = result(4);
    
    if (valid==1)
        saveIndex=saveIndex+1;
        if (mod(saveIndex,10*SampRate)==0)
            sprintf('%d second',saveIndex/SampRate)
        end
        dataSaved(:,saveIndex)=[chI;chQ];
    end
    
    if(saveIndex==Width)
        saveIndex=0;
        I=dataSaved(1,:);
        Q=dataSaved(2,:);
        
        % get f
        parameterSetting={[50 100 200 400 600 800 1000]};  
        nParam=length(parameterSetting);
        for i0=1:nParam
            nValue(i0)=length(parameterSetting{i0}); 
        end
        f=[];
        for i1=1:nValue(1)
            thr=parameterSetting{1}(i1); 
            f=[f,FeatureClass8_2(I,Q,thr)];
        end
        
        % get f 3_2
        
        
        
        % get instance from f
        instance = Instance(length(f)+1);
        for ii=1:length(f)
            instance.setValue(ii-1, f(ii));
        end
        instance.setDataset(instances_train);
        
        % predict
        eval = Evaluation(instances_train);
        
        numPeople=eval.evaluateModelOnce(classifier,instance) %AndRecordPrediction
    end
end

