%{
    Given start time and duration of a clip this function prints the
    endtime of the clip
    Ex: If start time is 1:22:00, and duration is 38:36 function call should
    be  startTime(1,22,0,38,36)
%}
function endTime(start_hrs,start_min,start_secs, dur_min, dur_secs)
    cur_time = datetime;
    cur_year = year(cur_time);
    cur_month = month(cur_time);
    cur_day = day(cur_time); 
    
    start_time = datetime(cur_year, cur_month, cur_day, start_hrs, start_min, start_secs);
    %disp(end_time);
    end_time = start_time + minutes(dur_min);
    end_time = end_time + seconds(dur_secs);
    disp(end_time);
end