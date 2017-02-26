function Result = Corr(A,B)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Extra code required if A & B are different lengths.

N = length(A);
if lenght(B) ~= N
  ERROR('Supoort for vectors of different lenghts not implemented');
end

ATran = fft(A);
BTran = fft(B);
Mod = 2*IsEven([0 : N-1]) - 1;

ProdTran = ATran .* BTran .* Mod;

Result = ifft(ProdTran);