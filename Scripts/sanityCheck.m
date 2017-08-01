function sanityCheck(hrs, minute, second)
SetEnvironment;
SetPath;

cur_time = datetime;
cur_year = year(cur_time);
cur_month = month(cur_time);
cur_day = day(cur_time);

%start = [264 482 586 843 857 920 1193 1652 1680 1870 1912 2180 2944 3328 3341 3488 3492 3515 4482 5624];
%stop = [266 484 588 845 857 929 1194 1652 1686 1873 1920 2182 2947 3329 3351 3490 3498 3522 4496 5629];

start_time = datetime(cur_year, cur_month, cur_day, hrs, minute, second);
disp(start_time);

%path to the files containing start and end times from the cuts
file_path_beginnings = strcat(g_str_pathbase_data,'/Bike data/March 25 2017/Detect_begs_and_ends/param0.9_newcode/detect_beginnings__North1');
file_path_ends = strcat(g_str_pathbase_data,'/Bike data/March 25 2017/Detect_begs_and_ends/param0.9_newcode/detect_ends__North1');
%disp(file_path);
%disp(length(files));
%walk through all the files
start = [];
stop = [];

   %cur_file = strcat('/',files(i).name);
   fd = fopen(file_path_beginnings,'r');
   while(~feof(fd))
       line = fgets(fd);
       line = str2num(line);
       %disp(line);
       start = [start line];
   end
   fclose(fd);
   fd = fopen(file_path_ends,'r');
   while(~feof(fd))
       line = fgets(fd);
       line = str2num(line);
       %disp(line);
       stop = [stop line];
   end
   fclose(fd);

start = start/2;
stop = stop/2;

%disp(start);
%disp(stop);
start_arr = [start_time+seconds(start(1))];
temp = start_time + seconds(stop(1));
stop_arr = [temp];
for i = 2:length(start)
    t = start(i);
    t1 = stop(i);
    half = (t1 - t); %disp(half);
    temp = start_time + seconds(t);
    %temp1 = start_time + seconds(t1);
    %a = temp1 - temp;
    temp1 = temp + seconds(half);
    %disp(temp);
    start_arr = [start_arr temp];
    stop_arr = [stop_arr temp1];
end

output_file_path = strcat(g_str_pathbase_data,'/Bike data/March 25 2017/Detect_begs_and_ends/param0.9_newcode/times_North1');
fd = fopen(output_file_path,'w');
for i = 1:length(start_arr)
    [h,m,s] = hms(start_arr(i));
    [h1,m1,s1] = hms(stop_arr(i));    
    fprintf(fd,'%d:%d:%d - %d:%d:%d\n',round(h),m,s,h1,m1,s1);
end

fclose(fd);
%disp(start_arr);
%disp(stop_arr);

end