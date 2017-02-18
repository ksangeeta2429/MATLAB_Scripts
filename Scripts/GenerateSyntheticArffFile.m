%%%% Generate synthetic data by change the arff file and generate synthetic
%%%% data at the end of the file

% function GenerateSyntheticArffFile(OutIndex)

OutIndex = 227;
scaling=[0.4,0.6,0.8,1.2,1.4,1.6]; 


path_data = 'C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\IIITDemo\Arff';
fileName = ['radar',int2str(OutIndex),'.arff'];

cd(path_data);
fidin=fopen(fileName,'r');
fileName_new = ['radar',int2str(OutIndex),'_synthetic.arff'];
fidout=fopen(fileName_new,'w');

data = fread(fidin, inf, '*char');
data = data'

tmp = strfind(data,'@data');
header = data(1:tmp+5);
data = data(tmp+6:length(data));


rows = strsplit(data,[char(13),char(10)]);
rows = rows(1:length(rows)-1); % last line is empty line in arff file

nData = length(rows);
nFeature = length(strsplit(rows{1},','))-1;

FeatureVectors = zeros(nData,nFeature);
Labels = cell(nData,1);

for i=1:length(rows)
    row = strsplit(rows{i},',');
    FeatureVectors(i,:) = str2double(row(1:length(row)-1));
    Labels{i} = row(length(row));
end


fprintf(fidout,header);
fprintf(fidout,data);



nGroupOfSynthetic=length(scaling);
scalingFactors=ones(nGroupOfSynthetic,nFeature);
index=[1,7,12];
index=[2];

for p=1:nGroupOfSynthetic
    scalingFactors(p,index)= ones(1,length(index))*scaling(p);
end

for k=1:size(scalingFactors,1)
    rowstext_new = cell(nData,1);
    for i=1:length(rows)
        fv = FeatureVectors(i,:);


        fv_new = fv.*scalingFactors(k,:);

        rowstext_new{i}='';
        for j=1:length(fv_new)
            rowstext_new{i} = [rowstext_new{i},num2str(fv_new(j)),','];
        end
        rowstext_new{i} = [rowstext_new{i},Labels{i}{1},char(13),char(10)]; 
    end
    for i=1:length(rowstext_new)
        fprintf(fidout,rowstext_new{i});
    end
end
fclose('all');
% fwrite(fid, Data, 'int16');
