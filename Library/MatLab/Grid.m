function Result = Grid(Low,High,N)

Result = (High - Low) * [0 : N-1]/(N-1) + Low;