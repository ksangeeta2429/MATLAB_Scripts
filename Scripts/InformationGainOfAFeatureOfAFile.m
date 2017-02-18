function [output, info_gains_matrix] = InformationGainOfAFeatureOfAFile(path_arff, top_k)
cd(path_arff);
envFiles = dir('*.arff');

for k=1:length(envFiles)
    %instances = loadARFF(sprintf('radar%d.arff',OutIndex));
    instances = loadARFF(envFiles(k).name);
    N=instances.numAttributes;
    M=instances.numInstances();
    
    x=zeros(M,N-1);
    y=zeros(M,1);
    
    % Populate feature values corresponding to all instances
    for j=1:N-1
        x(:,j)=instances.attributeToDoubleArray(j-1); 
    end
    
    y=instances.attributeToDoubleArray(N-1); % Populate class identifiers (0,1 for binary)
    
    % function [max_gain_feature, gain] = infogain(x,y)
    
    max_gain_feature = 0;
    info_gains = zeros(1, size(x,2));
    
    %calculate H(y) -- entropy
    classes = unique(y); % This determines the number of classes, 2 in our case
    hy = 0;
    for c=classes'
        py = sum(y==c)/size(y,1);
        hy = hy + py*log2(py);
    end
    hy = -hy;
    
    %iterate over all features (columns)
    for col=1:size(x,2)
        
        features = unique(x(:,col));
        maxFeature = max(x(:,col));
        minFeature = min(x(:,col));
        nIntervals = 6;
        lenInterval = (maxFeature-minFeature)/nIntervals;
        points = minFeature+(0:nIntervals)*lenInterval;
        
        
        %calculate entropy
        hyx = 0;
        %         for f=features'
        for i=1:nIntervals
            
            %pf = sum(x(:,col)==f)/size(x,1);
            if i~=nIntervals
                pf = sum(x(:,col)>=points(i) & x(:,col)<points(i+1))/size(x,1);
                yf = y(x(:,col)>=points(i) & x(:,col)<points(i+1));
            else
                pf = sum(x(:,col)>=points(i) & x(:,col)<=points(i+1))/size(x,1);
                yf = y(x(:,col)>=points(i) & x(:,col)<=points(i+1));
            end
            
            
            
            %calculate h for classes given feature f
            yclasses = unique(yf);
            hyf = 0;
            for yc=yclasses'
                pyf = sum(yf==yc)/size(yf,1);
                hyf = hyf + pyf*log2(pyf);
            end
            hyf = -hyf;
            
            hyx =  hyx+ pf * hyf;
            
        end
        
        info_gains(col) = hy - hyx;
        
    end
    info_gains_matrix(:,k)=info_gains;
    %[gain, max_gain_feature] = max(info_gains)
end

if size(info_gains_matrix, 2) ==1
    %% If single environment, get top-k features
    [sortedValues,sortIndex] = sort(info_gains_matrix(:),'descend');
    maxkIndex = sort(sortIndex(1:top_k)'); % Find top k indices (i.e. feature numbers)
    output = maxkIndex; % If a single environment, return the top k information gain feature indices
else
    %% If many environments, get information gain statistics
    for k=1:size(info_gains_matrix,1)
        info_gain_stats(k,:)=[mean(info_gains_matrix(k,:)), std(info_gains_matrix(k,:)), var(info_gains_matrix(k,:))];
        output = info_gain_stats;
    end
end