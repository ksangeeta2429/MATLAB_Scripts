%{
    Given start time and duration of a clip this function prints the
    endtime of the clip
    1.42 means 1:42 PM or AM. 13.32 means 13:32 PM
    duration is in same format, but represents time period rather than
    absolute time. Ex: 38.36 represents 38 minutes and 36 seconds
    Final result i.e end_time : Ex: 12.44 - 12 hrs and 44 minutes on
    clock is the end time
%}
function endTime(end_time, duration)
    if(end_time > 12)
        mod_value = 24;
    else
        mod_value = 12;
    end
    integer = floor(duration);
    seconds = duration - integer;
     %convert the seconds part to minutes
    minutes = seconds / 60;
    %add to integer to get the duration in minutes
    dur_minutes = integer + minutes;
    fprintf('Duration in minutes');
    disp(dur_minutes);
    
    integer = floor(end_time);
    fract = end_time - integer;
    hrs = fract * 100 / 60;
    start_hrs = integer + hrs;
    fprintf('Start time in hrs');  disp(start_hrs);
    
    dur_hrs = (dur_minutes / 60);
    end_hrs = start_hrs + dur_hrs;
    fprintf('End time in hrs');  disp(end_hrs);
    if(mod_value == 12)
        if(end_hrs >= mod_value + 1)
            end_hrs = end_hrs - mod_value;
        end
    end
    if(mod_value == 24)
         if(end_hrs > mod_value)
            end_hrs = end_hrs - mod_value;
        end
    end
    fprintf('End time in hrs');  disp(end_hrs);
    
    integer = floor(end_hrs);
    fract = end_hrs - integer;
    temp = fract * 60;
    temp = temp / 100;
    end_time = temp + integer;
    fprintf('End time is %d hours and %d minutes',integer,temp * 100);
    end_time = round(end_time * 100)/100;
    disp(end_time);
end