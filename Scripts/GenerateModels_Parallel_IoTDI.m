function Results = GenerateModels_Parallel_IoTDI(path_models, path_arff)
cd(path_arff);
fileFullNames=dir;

Files={};  % first 2 file is '.' and '..'
Results={};
i=1;
for j=1:length(fileFullNames)
    s=fileFullNames(j).name;
    k=strfind(s,'.arff');
    if ~isempty(k) && k>=2 && k+4==length(s) % k+4==length(s) to avoid .data.emf file
        Files{i}=s(1:k-1);
        i=i+1;
    end
end

%% Populate c-gamma combos
i = 1;
for c=[0.001 0.01 0.1 1 10 100 1000 100000 1000000]
    for gamma=[0.001 0.01 0.05 0.1 0.5 1 5 10]
        comb_c_gamma{i} = [c gamma];
        i=i+1;
    end
end

for i=1:length(Files) % take every file from the set 'Files'
    fileName=Files{i};
    fprintf('Processing file %s.arff...\n',fileName);

    % Run grid-search in parallel
    acc_result=zeros(1, length(comb_c_gamma));
    parfor j=1:length(comb_c_gamma)
        cur = comb_c_gamma{j};
        c = cur(1);
        gamma=cur(2);
        fprintf('\tAttempting with c=%d, gamma=%d\n', c, gamma);
        [~, accuracy, ~, ~] = Crossval_new(path_models,path_arff,fileName,c, gamma,0);
        acc_result(j) = accuracy;
    end
    
    % Get best grid search parameters
    [accuracy_max, maxIndex] = max(acc_result);
    c_max = comb_c_gamma{maxIndex}(1);
    gamma_max = comb_c_gamma{maxIndex}(2);
    fprintf('\tGenerating model with c_max=%d, gamma_max=%d, accuracy=%f%%\n', c_max, gamma_max, accuracy_max);
    evalc('Crossval_new(path_models,path_arff,fileName,c_max, gamma_max,1)'); % renew the model txt file
    
    Results=[Results;{fileName}, c_max, gamma_max, accuracy_max];
end