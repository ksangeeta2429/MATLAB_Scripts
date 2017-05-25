%{
    Given end time and duration of a video print the start time of the
    video
    Ex: If end time is 1:22:00, and duration is 38:36 function call should
    be  startTime(1,22,0,38,36)
%}

function startTime(end_hrs,end_minutes, end_secs, duration_min, duration_secs)
    cur_time = datetime;
    cur_year = year(cur_time);
    cur_month = month(cur_time);
    cur_day = day(cur_time); 
    
    end_time = datetime(cur_year, cur_month, cur_day, end_hrs, end_minutes, end_secs);
    %disp(end_time);
    start_time = end_time - minutes(duration_min);
    start_time = start_time - seconds(duration_secs);
    disp(start_time);
end