SetEnvironment
SetPath
arff_folder = {'1_4_5_6_7_8_9_220161_220162_524163'};

rnd=100;

for fld=1:length(arff_folder)
    % for cur_rnd={'10' '20' '30' '40' '50' '60'}
    for cur_rnd={'15'}
        fprintf('###### EXECUTING ROUND %s #####\n', char(cur_rnd));
        fldr = char(arff_folder{fld});
        evalstr=strcat('crossenv_',fldr,'_r1_top',char(cur_rnd),'=CrossEnvs_BigEnvs_ToSN(rnd,fldr,str2num(char(cur_rnd)));');
        eval([evalstr]);
    end
end


% for cur_rnd={'10' '20' '30' '40' '50' '60'}
for cur_rnd={'15'}
    fldr = char(arff_folder{1});
    eval(['crossenv_str_' char(cur_rnd) '=crossenv_' fldr '_r1_top' char(cur_rnd) ';']);
end


for fld=2:length(arff_folder)
    % for cur_rnd={'10' '20' '30' '40' '50' '60'}
    for cur_rnd={'15'}
        fldr = char(arff_folder{fld});
        eval(['crossenv_str_' char(cur_rnd) '=[crossenv_str_' char(cur_rnd) '; crossenv_' fldr '_r1_top' char(cur_rnd) '];']);
    end
end

path_temp = 'C:\Users\royd\Box Sync\All_programs_data_IPSN_2016\Results\Claim demos\WWFFeaures_87features';
if exist(path_temp, 'dir') ~= 7
        mkdir(path_temp); % Includes path_to_topk_arffs_scaled
        fprintf('INFO: created directory %s\n', path_temp);
end

cd(path_temp);

% dlmwrite('crossenv_str_10.csv',crossenv_str_10);
dlmwrite('crossenv_str_15_trainingtestingsame.csv',crossenv_str_15);
% dlmwrite('crossenv_str_20.csv',crossenv_str_20);
% dlmwrite('crossenv_str_30.csv',crossenv_str_30);
% dlmwrite('crossenv_str_40.csv',crossenv_str_40);
% dlmwrite('crossenv_str_50.csv',crossenv_str_50);
% dlmwrite('crossenv_str_60.csv',crossenv_str_60);
