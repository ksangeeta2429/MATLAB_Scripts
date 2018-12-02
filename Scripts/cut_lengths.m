SetEnvironment
SetPath

%path = strcat(g_str_pathbase_data,'/Human_vs_non_human_training_new_detector/M_30_N_128_window_res/last_wind_padded_with_signal/austere_384_human/')
%path = strcat(g_str_pathbase_data,'/Human_vs_non_human_training_new_detector/M_30_N_64_window_res/austere_311_cow/')
%path = strcat(g_str_pathbase_data,'/Human_vs_non_human_training_new_detector/M_30_N_256_window_res/austere_364_human/')

%bikes
path = strcat(g_str_pathbase_data,'/Human_vs_bike_training_new_detector/M_30_N_128_window_res/last_wind_padded_with_signal/Bike/')
%path = strcat(g_str_pathbase_data,'/Bike data/Aug 13 2018/Detect_begs_and_ends/c1/t22/bgr19/aus/cut/')
oldFolder = cd(path);
fileFullNames=dir;

Files={};  % first 2 file is '.' and '..'
i=1;
for j=1:length(fileFullNames)
    s=fileFullNames(j).name;
    k=strfind(s,'.data');
    if ~isempty(k) && k>=2 && k+4==length(s) % k+4==length(s) to avoid .data.emf file
        Files{i}=s(1:k-1);
        i=i+1;
    end
end
p = 0;
for i=1:length(Files) % take every file from the set 'Files'
    if mod(i,10)==0
        %sprintf('Human - %dth file is processing\n',i) % Report every 10 files-the i-th file is processing
    end
    fileName=Files{i};
    [I,Q,N]=Data2IQ(ReadBin([fileName,'.data']));

 
    
    
    Data = I + 1i * Q;
    if(length(Data) < 256)
        move_to_f = strcat('less_than_',num2str(512/256));   
        if(exist(move_to_f,'dir') ~= 7)
            mkdir(move_to_f);
            fprintf('INFO: created directory %s\n', move_to_f);
        end
        fprintf('%s length : %d\n',fileName,length(Data));  
    end
    if(length(Data) > 3840)
        p = p + 1;
        %split into multiple cuts
        cut_down_to = 15;
        for k = 1:256*cut_down_to:ceil(length(Data)/(256*cut_down_to))*256*cut_down_to
            k;
            length(Data);
            if(k-1 == (ceil(length(Data)/(256*cut_down_to))-1)*256*cut_down_to)
                I_temp = I(k:end);
                Q_temp = Q(k:end);
                Data_cut_temp = zeros(1,2*length(I_temp));
                fprintf('Creating new file : %s\n',[fileName,'_',num2str(k),'_to_',num2str(k+length(I_temp)-1),'.data']);
                fprintf('Length : %d\n',length(I_temp));
                WriteBin([fileName,'_',num2str(k),'_to_',num2str(k+length(I_temp)-1),'.data'],Data_cut_temp);
            else
                I_temp = I(k:k+cut_down_to*256-1);
                Q_temp = Q(k:k+cut_down_to*256-1);
                Data_cut_temp = zeros(1,2*length(I_temp));
                Data_cut_temp(1:2:end-1) = I_temp;
                Data_cut_temp(2:2:end) = Q_temp;
                fprintf('Creating new file : %s\n',[fileName,'_',num2str(k),'_to_',num2str(k+256*cut_down_to-1),'.data']);
                fprintf('Length : %d\n',length(I_temp));
                WriteBin([fileName,'_',num2str(k),'_to_',num2str(k+256*cut_down_to-1),'.data'],Data_cut_temp);  
            end
        end
        fprintf('%s length : %d\n',fileName,length(Data));
        move_to = strcat('greater_than_',num2str(3840/256));
        
        
        if(exist(move_to,'dir') ~= 7)
            mkdir(move_to);
            fprintf('INFO: created directory %s\n', move_to);
        end
        %{
        
        fprintf('Moving %s to %s\n',fileName,move_to);

        [status,message,messageId] = movefile(strcat(fileName,'.data'),strcat('\',move_to,'\',fileName,'.data'));
        if(status == 0)
            fprintf('Error : %s',message);
            return;
        end
        %}
    end
end
cd(oldFolder);
p