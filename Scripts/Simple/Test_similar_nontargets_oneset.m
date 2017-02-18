SetEnvironment
SetPath

%% Learning from dogs
arff_folder = {'589'};
testFiles = {'1', '4', '6'};

%% Begin program
rnd=-30;

for fld=1:length(arff_folder)
    for cur_rnd={'10' '20' '30' '40' '50' '60'}
        fprintf('###### EXECUTING ROUND %s #####\n', char(cur_rnd));
        fldr = char(arff_folder{fld});
        evalstr=strcat('crossenv_',fldr,'_r1_top',char(cur_rnd),'=CrossEnvs_BigEnvs_ToSN(rnd,fldr,str2num(char(cur_rnd)));');
        eval([evalstr]);
    end
end


for cur_rnd={'10' '20' '30' '40' '50' '60'}
    fldr = char(arff_folder{1});
    eval(['crossenv_str_' char(cur_rnd) '=crossenv_' fldr '_r1_top' char(cur_rnd) ';']);
end


for fld=2:length(arff_folder)
    for cur_rnd={'10' '20' '30' '40' '50' '60'}
        fldr = char(arff_folder{fld});
        eval(['crossenv_str_' char(cur_rnd) '=[crossenv_str_' char(cur_rnd) '; crossenv_' fldr '_r1_top' char(cur_rnd) '];']);
    end
end

cd C:\Users\royd\Desktop\ClutterSame
dlmwrite('crossenv_str_10.csv',crossenv_str_10);
dlmwrite('crossenv_str_20.csv',crossenv_str_20);
dlmwrite('crossenv_str_30.csv',crossenv_str_30);
dlmwrite('crossenv_str_40.csv',crossenv_str_40);
dlmwrite('crossenv_str_50.csv',crossenv_str_50);
dlmwrite('crossenv_str_60.csv',crossenv_str_60);