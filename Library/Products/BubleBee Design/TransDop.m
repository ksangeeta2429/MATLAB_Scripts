function G = TransA(S)

G = TransLP(S) .* TransA(S) .^ 2;