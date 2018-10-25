function qd_diff = findNumQuadrantChanges(Comp, qd, numQuads)
%%
if ~exist('numQuads','var') || isempty(numQuads), numQuads = 4; end


qd_diff_raw = qd(2:end) - qd(1:end-1);
qd_diff = qd_diff_raw;

for i = numQuads-1:-1:numQuads/2+1
    qd_diff(qd_diff_raw==i) = i-numQuads;
end
for i = (-1*(numQuads-1)):1:(-1*(numQuads/2+1))
    qd_diff(qd_diff_raw==i) = i+numQuads;
end

%% Handle the case with more than 2 quadrant changes by looking at the sign of change
dot_prod = real(Comp(1:end-1)).*imag(Comp(2:end)) - imag(Comp(1:end-1)).*real(Comp(2:end));
%is_rotation_zero = dot_prod==0;
is_rotation_sign_pos = dot_prod>0;
is_rotation_sign_neg = dot_prod<0;

qd_diff(and(is_rotation_sign_pos, or(qd_diff_raw==-numQuads/2,qd_diff_raw==numQuads/2))) = numQuads/2;
qd_diff(and(is_rotation_sign_neg, or(qd_diff_raw==-numQuads/2,qd_diff_raw==numQuads/2))) = -numQuads/2;



if(size(Comp,1) == 1), qd_diff= [0 qd_diff];
else qd_diff= [0;qd_diff];
end

end

