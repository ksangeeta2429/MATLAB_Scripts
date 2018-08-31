function [start_time_sec,stop_time_sec] = convertTimeStampsToSeconds(eventTimes,sheetName,range,militaryFormat)
    
    cur_time = datetime;
    cur_year = year(cur_time);
    cur_month = month(cur_time);
    cur_day = day(cur_time);
    
    all_data = xlsread(eventTimes,sheetName,range);
    
    start_time = []; stop_time = [];
    for i = 1:size(all_data,1)
        if(not(isnan(all_data(i,1))) & not(isnan(all_data(i,2))))
            start_time = [start_time all_data(i,1)];
            stop_time = [stop_time all_data(i,2)];
        end
    end    
    
    start_time;
    stop_time;
    
    start_time_sec = []; stop_time_sec = [];
    if(militaryFormat == 1)
    for i = 1:length(start_time)
        %{
        temp_start = datestr(start_time(i)+datenum('30-12-1899'))
        temp_stop = datestr(stop_time(i)+datenum('30-12-1899'))
        
        if(start_time(i) == 0)
            start_time_dt = datetime(cur_year,cur_month,cur_day,0,0,0);
        else
            start_time_dt = datetime(temp_start,'InputFormat','dd-MM-yyyy HH:MM:SS');
        end
        
        if(stop_time(i) == 0)
            stop_time_dt = datetime(cur_year,cur_month,cur_day,0,0,0);
        else
            stop_time_dt = datetime(temp_stop,'InputFormat','dd-MM-yyyy HH:MM:SS');
        end
        %}
        %start_sec = datenum(temp_start);
        %stop_sec = datenum(temp_stop);
        
        t_start = days(start_time(i));
        t_stop = days(stop_time(i));
        
        t_start.Format = 'hh:mm:ss';
        t_stop.Format = 'hh:mm:ss';
        
        [h,m,s] = hms(t_start);
        start_sec = h * 3600 + m * 60 + s;
        
        [h,m,s] = hms(t_stop);
        stop_sec = h * 3600 + m * 60 + s;
        
        start_time_sec = [start_time_sec start_sec];
        stop_time_sec = [stop_time_sec stop_sec];
    end
    else
        start_time_sec = start_time;
        stop_time_sec = stop_time;
    end
end