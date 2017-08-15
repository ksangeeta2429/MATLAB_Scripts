

%inputFile = fopen('D:\Main\Work\SOURCE\WORKING\eMote\MicroFrameworkPK_v4_3\Samraksh\APPS\DataCollectorHost\DataCollectorHost\bin\Debug\NOR2.dat', 'r');
iFile = fopen('D:\Main\Work\SOURCE\WORKING\eMote\MicroFrameworkPK_v4_3\Samraksh\APPS\DataFormatter\DataFormatter\bin\Debug\111.dat_I', 'r');
qFile = fopen('D:\Main\Work\SOURCE\WORKING\eMote\MicroFrameworkPK_v4_3\Samraksh\APPS\DataFormatter\DataFormatter\bin\Debug\111.dat_Q', 'r');
iinput = fread(iFile, '*uint16');
qinput = fread(qFile, '*uint16');
%input = fread(inputFile,'*uint16');

%subplot(2,1,1);
%figure;
%for i=1:length(iinput)
%    plot(i,iinput(i),'b*')
%end
%subplot(2,1,2);
%figure;

for i=1:length(qinput)
    qinput(i) = qinput(i) - 4001;
end;

plot(iinput,'r*');
hold on;
plot(qinput,'b*');
%plot(input(2:2:length(input))
%plot(input)



