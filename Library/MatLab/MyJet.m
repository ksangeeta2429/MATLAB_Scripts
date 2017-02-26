function ColorList = MyJet(N)

Hue = 2/3 * [0 : N-1] / (N-1);
ColorList = hsv2rgb([Hue', ones(N,2)]);