function Result = RandLog(N, Low,High)

LogLow = log(Low);
LogRange = log(High) - LogLow;

Result = exp(LogLow + LogRange*rand(1,N));