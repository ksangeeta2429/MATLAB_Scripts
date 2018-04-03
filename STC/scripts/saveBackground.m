function saveBackground()

Files_bg={'266_0p_rb26','357_0p_lb1','317_0p_lb2','369_0p_lb','2019_0p_rb1'};   

for i=1:length(Files_bg)
    STCParse(Files_bg{i})
end