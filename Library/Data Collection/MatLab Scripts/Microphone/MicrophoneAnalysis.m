micRawData = fopen('D:\Users\Ananth\Dropbox (Samraksh)\Summer2014-DataCollection\From Tony\test5.dat');
micInput = fread(micRawData);

plot(micInput,'r*');
