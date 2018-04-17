img = zeros(664,100);  %demo image
numperiods = 8;
amplitude = 10; %pixels
offset = 10;
x = 1:0.25:size(img, 2);  %pixel subsampling for better resolution
y = sin(x*2*pi/size(img, 2)*numperiods)*amplitude + offset;
img(sub2ind(size(img), round(y), round(x))) = 1;
imshow(img);