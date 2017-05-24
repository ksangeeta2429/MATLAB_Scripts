%{
    Given end time and duration of a video print the start time of the
    video
    end_time should be in format Digit Digit . Digit... 
    Ex: 1.42 means 1:42 PM or AM. 13.32 means 13:32 PM
    duration is in same format, but represents time period rather than
    absolute time. Ex: 38.36 represents 38 minutes and 36 seconds
    Final result i.e start_time : Ex: 12.44 - 12 hrs and 44 minutes on
    clock is the start time
%}

function startTime(end_time, duration)
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
    end_hrs = integer + hrs;
    fprintf('End time in hrs');  disp(end_hrs);
    
    dur_hrs = (dur_minutes / 60);
    start_hrs = end_hrs - dur_hrs;
    
    fprintf('Start time in hrs');  disp(start_hrs);
    if(start_hrs < 0)
        start_hrs = mod_value + start_hrs;
    end
    integer = floor(start_hrs);
    if(integer == 0)
        start_hrs = mod_value + start_hrs;
    end
    fprintf('Start time in hrs');  disp(start_hrs);
    
    integer = floor(start_hrs);
    fract = start_hrs - integer;
    temp = fract * 60;
    temp = temp / 100;
    start_time = temp + integer;
    fprintf('Start time is %d hours and %d minutes',integer,temp * 100);
    start_time = round(start_time * 100)/100;
    disp(start_time);
end