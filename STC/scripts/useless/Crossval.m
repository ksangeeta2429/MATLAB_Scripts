% OutIndex
% indexOfDataset
% fold


function mean_abs_err=Crossval(OutIndex,indexOfDataset,fold)
addpath ./matlab2weka;
ifReg=0;
ifCrossval=1;

% OutIndex=6;
% indexOfDataset=10;
% fold=10;


%% Load data
instances = loadARFF(sprintf('../arff files/radar%d.arff',OutIndex));
if ifReg==1
    [f_set, featureNames]=weka2matlab(instances,[]);
else 
    [f_set, featureNames]=weka2matlab(instances,{});
end

if ifCrossval==1
    %% Get k-fold division of indexes in the set
    Files=ChooseFile(indexOfDataset);
    
    % Get the k-fold divion of the whole set
    indexDivision=KFoldDivision(Files,fold);

    %% Cross validation
    predicted=[];
    actual=[];
    for i=1:fold
        fold_i=i
        f_test=f_set(indexDivision{i},:);
        index_train=[];
        for j=1:fold
            if j~=i
                index_train=[index_train,indexDivision{j}];
            end
        end
        f_train=f_set(index_train,:);
        nColumn=size(f_set,2);
        wekaobj_train = matlab2weka('train',featureNames,f_train,nColumn); 
        wekaobj_test =  matlab2weka('test',featureNames,f_test,nColumn);  
        %% Train the classifier 

        %type='functions.SMOreg';
        %options='weka.classifiers.functions.SMOreg -C 1.0 -N 0 -I "weka.classifiers.functions.supportVector.RegSMOImproved -L 0.0010 -W 1 -P 1.0E-12 -T 0.0010 -V" -K "weka.classifiers.functions.supportVector.Puk -C 250007 -O 1.0 -S 1.0"';

        type='functions.SMO';
        %options='weka.classifiers.functions.SMO -C 1.0 -L 0.0010 -P 1.0E-12 -N 0 -V -1 -W 1 -K "weka.classifiers.functions.supportVector.PolyKernel -C 250007 -E 1.0"';
        options='weka.classifiers.functions.SMO -C 1.0 -L 0.0010 -P 1.0E-12 -N 0 -V -1 -W 1 -K "weka.classifiers.functions.supportVector.Puk -C 250007 -O 1.0 -S 1.0"';
        
        classifier = trainWekaClassifier(wekaobj_train,type,options); 
        %% Use the classifier to predict
        if ifReg==1
            predicted = [predicted; wekaReg(wekaobj_test,classifier)];
        else
            predicted = [predicted; wekaClassify(wekaobj_test,classifier)];
        end
        %The actual class labels (i.e. indices thereof)
        actual = [actual; wekaobj_test.attributeToDoubleArray(nColumn-1)]; %java indexes from 0
    end
    errorRate = sum(actual ~= predicted)/length(actual)
    [C,order]=confusionmat(actual,predicted)
    corrCoef=corr(actual,predicted)
    mean_abs_err = mean(abs(actual-predicted))
    rms_err=(mean((actual-predicted).^2))^0.5
    
    
    
else   % use full set as both train and test 
    nColumn=size(f_set,2);
    wekaobj_train = matlab2weka('train',featureNames,f_set,nColumn); 
    wekaobj_test =  matlab2weka('test',featureNames,f_set,nColumn);  
    %% Train the classifier 

    %type='functions.SMOreg';
    %options='weka.classifiers.functions.SMOreg -C 1.0 -N 0 -I "weka.classifiers.functions.supportVector.RegSMOImproved -L 0.0010 -W 1 -P 1.0E-12 -T 0.0010 -V" -K "weka.classifiers.functions.supportVector.Puk -C 250007 -O 1.0 -S 1.0"';

    type='functions.SMO';
    options='weka.classifiers.functions.SMO -C 1.0 -L 0.0010 -P 1.0E-12 -N 0 -V -1 -W 1 -K "weka.classifiers.functions.supportVector.PolyKernel -C 250007 -E 1.0"';
    classifier = trainWekaClassifier(wekaobj_train,type,options); 
    %% Use the classifier to predict
    if ifReg==1
        predicted = wekaReg(wekaobj_test,classifier);
    else
        predicted = wekaClassify(wekaobj_test,classifier);
    end
    %The actual class labels (i.e. indices thereof)
    actual = wekaobj_test.attributeToDoubleArray(nColumn-1); %java indexes from 0
    [C,order]=confusionmat(actual,predicted)
    
end