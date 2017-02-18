function predictedVal = wekaReg(testData,classifier)

if(~wekaPathCheck),predictedVal = []; return,end

predictedVal=zeros(testData.numInstances,1);
for i=1:testData.numInstances
  predictedVal(i) = classifier.classifyInstance(testData.instance(i-1));
end