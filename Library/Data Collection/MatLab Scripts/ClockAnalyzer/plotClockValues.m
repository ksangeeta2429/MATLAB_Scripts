function r = plotClockValues(LAMemMap,curIndexNumbers)
    x = double((curIndexNumbers+1)/2)' ; % HSI Clcok tick number
    y = double(LAMemMap.Data(curIndexNumbers)'); %Logic analxzer clock tick number
    
    
    p = polyfit(x,y,1);
    r = polyval(p,x) - y;
    
% % %    p4 = findLineFit_usingChunkOperations(LAMemMap,curIndexNumbers);
% %     
    x2 = x/(16*10^6); % HSI Clcok time value in s assuming 8 Mhz clock
    y2 = y /(32*10^6); %Logic analxzer time value in s assuming 32 Mhz sampling rate
    p2 = polyfit(x2,y2,1);
    r2 = polyval(p2,x2) - y2;
    
    p3 = polyfit(x,y2,1);
    r3 = polyval(p3,x) - y2;
    
    h_fig = figure();
    h_ayes = gca;
    hold on;
    xlabel('HSI Clcok time value in s assuming 8 Mhz clock');
    ylabel('Logic analxzer time value in s assuming 32 Mhz sampling rate');
    plot(x2,y2,'DisplayName', 'raw');
    plot(x2,polyval(p2,x2), 'r','DisplayName','fitted');
    plot(y2,y2,'g','DisplayName','y=x')
    plot(polyval(p3,x),y2,'k','DisplayName','Calibrated HSI')
    legend(h_ayes,'show');
    grid on;
    
end