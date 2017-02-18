function Results = GenerateModels_IoTDI(path_models, path_arff)
%path_arff_nr = strcat(g_str_pathbase_radar,'\IIITDemo\Arff\jin_matlab\filtered');
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

for i=1:length(Files) % take every file from the set 'Files'
    fileName=Files{i};
    fprintf('Processing file %s.arff...\n',fileName);
    %totalNumInstances = size(f_set,1); % 52;
    accuracy_max = 0;
    c_max=0;
    gamma_max=0;
    for c=[0.001 0.01 0.1 1 10 100 1000 100000 1000000] %[1 2 3 4 5 6 7 8 9 10 20 30 40 50 60 70 80 90 100]
        for gamma=[0.001 0.01 0.05 0.1 0.5 1 5 10] %[0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.1]
            fprintf('\tAttempting with c=%d, gamma=%d\n', c, gamma);
            [~, accuracy, ~, ~] = Crossval_new(path_models,path_arff,fileName,c, gamma,0);
            %accuracy = (confusionmatrix(1,1) + confusionmatrix(2,2))/totalNumInstances;
            %accuracy = (confusionmatrix(1,1) + confusionmatrix(2,2));
            if (accuracy > accuracy_max)
                accuracy_max = accuracy;
                c_max = c;
                gamma_max =gamma;
            end
        end
    end
    fprintf('\tGenerating model with c_max=%d, gamma_max=%d, accuracy=%f%%\n', c_max, gamma_max, accuracy_max);
    [~, full_path_model, accuracy, result, confusionmatrix] = evalc('Crossval_new(path_models,path_arff,fileName,c_max, gamma_max,1)'); % renew the model txt file
    % [~, full_path_model, accuracy, result, confusionmatrix] = Crossval_new(path_models,path_arff,fileName,c_max, gamma_max,1); % renew the model txt file

    Results=[Results;{fileName}, c_max, gamma_max, accuracy_max];
end
% 
% cd(path_arff_r);
% fileFullNames=dir;
% 
% Files={};  % first 2 file is '.' and '..'
% Results_r={};
% i=1;
% for j=1:length(fileFullNames)
%     s=fileFullNames(j).name;
%     k=strfind(s,'.arff');
%     if ~isempty(k) && k>=2 && k+4==length(s)
%         Files{i}=s(1:k-1);
%         i=i+1;
%     end
% end
% 
% 
% for i=1:length(Files) % take every file from the set 'Files'
%     fileName=Files{i};
%     fprintf('Processing file %s.arff...\n',fileName);
%     %totalNumInstances = size(f_set,1); % 52;
%     accuracy_max = 0;
%     c_max=0;
%     gamma_max=0;
%     for c=[0.001 0.01 0.1 1 10 100 1000 100000 1000000] %[1 2 3 4 5 6 7 8 9 10 20 30 40 50 60 70 80 90 100]
%         for gamma=[0.001 0.01 0.05 0.1 0.5 1 5 10] %[0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.1]
%             [~, accuracy, ~, ~] = Crossval_new(g_str_pathbase_model,path_arff_r,fileName,c, gamma,0);
%             %accuracy = (confusionmatrix(1,1) + confusionmatrix(2,2))/totalNumInstances;
%             %accuracy = (confusionmatrix(1,1) + confusionmatrix(2,2));
%             if (accuracy > accuracy_max)
%                 accuracy_max = accuracy;
%                 c_max = c;
%                 gamma_max =gamma;
%             end
%         end
%     end
%     fprintf('=====================Generating model for %s.arff with c_max=%d, gamma_max=%d=====================\n', fileName, c_max, gamma_max);
%     [full_path_model, accuracy, result, confusionmatrix] = Crossval_new(g_str_pathbase_model,path_arff_r,fileName,c_max, gamma_max,1); % renew the model txt file
%     Results_r=[Results_r;{fileName, c_max, gamma_max, accuracy}];
% end