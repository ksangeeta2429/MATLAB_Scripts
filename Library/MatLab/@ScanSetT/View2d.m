function View2d(Obj, X,Y)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% View2d -- Look at the scans as a gray scale image

Data = Obj.Data;

Pic = MakePic({Data}, [1 1 1], 'Sigma',1/8);

if nargin == 3
  image(X,Y, Pic);
else
  NumScan = Obj.NumScan;
  NumSamp = Obj.NumSamp;
  
  image([1:NumSamp],[1:NumScan], Pic);
end