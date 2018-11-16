function varargout = findqd_diff_Bora(Comp, numQuads, bgr)
%%

%%
if ~exist('numQuads','var') || isempty(numQuads), numQuads = 4; end
if(numQuads == 4)
    qd = findQuadrant4(Comp);
    
    qd_diff_raw = qd(2:end) - qd(1:end-1);
    qd_diff = qd_diff_raw;
    qd_diff(qd_diff_raw==3) = -1;
    qd_diff(qd_diff_raw==-3) = 1;
    
    %% Handle the case with more than 2 quadrant changes by looking at the sign of change
    dot_prod = real(Comp(1:end-1)).*imag(Comp(2:end)) - imag(Comp(1:end-1)).*real(Comp(2:end));
    is_ratation_zero = dot_prod==0;
    is_rotation_sign_pos = dot_prod>0;
    is_rotation_sign_neg = dot_prod<0;
    
    qd_diff(and(is_rotation_sign_pos, or(qd_diff_raw==-2,qd_diff_raw==2))) = 2;
    qd_diff(and(is_rotation_sign_neg, or(qd_diff_raw==-2,qd_diff_raw==2))) = -2;
elseif numQuads ==8
    qd = findQuadrant8(Comp);
    qd_diff_raw = qd(2:end) - qd(1:end-1);
    
    for i = numQuads-1:-1:numQuads/2+1
        qd_diff(qd_diff_raw==i) = i-numQuads;
    end
    for i = (-1*(numQuads-1)):1:(-1*(numQuads/2+1))
        qd_diff(qd_diff_raw==i) = i+numQuads;
    end
    
    %% Handle the case with more than 2 quadrant changes by looking at the sign of change
    dot_prod = real(Comp(1:end-1)).*imag(Comp(2:end)) - imag(Comp(1:end-1)).*real(Comp(2:end));
    is_ratation_zero = dot_prod==0;
    is_rotation_sign_pos = dot_prod>0;
    is_rotation_sign_neg = dot_prod<0;
    
    qd_diff(and(is_rotation_sign_pos, or(qd_diff_raw==-numQuads/2,qd_diff_raw==numQuads/2))) = numQuads/2;
    qd_diff(and(is_rotation_sign_neg, or(qd_diff_raw==-numQuads/2,qd_diff_raw==numQuads/2))) = -numQuads/2;
    
else
    error(['Unimplmented number of quadrants = ' num2str(numQuad)]);
end

if(size(qd_diff,1) == 1), qd_diff= [0 qd_diff];
else qd_diff= [0;qd_diff];
end

isabovebackgroundrejection = FindIsAboveBackGroundRejection(Comp, bgr);
if (size(isabovebackgroundrejection,1)==1),
    isabovebackgroundrejection_n = circshift(isabovebackgroundrejection,[0 1]);
else
    isabovebackgroundrejection_n = circshift(isabovebackgroundrejection,[1 0]);
end
qd_diff(~isabovebackgroundrejection) = 0;
qd_diff(~isabovebackgroundrejection_n) = 0;


change_in_isabove_bgr = diff([0;isabovebackgroundrejection;0]);
inds_f = find(change_in_isabove_bgr==1);
% inds_l = find(change_in_isabove_bgr==-1);
qd_unwrap = ones(size(qd));
cur_rots = 0;
for i = 1:numel(inds_f)
    ind_f = inds_f(i);
    if(i==numel(inds_f)), ind_f_l = numel(isabovebackgroundrejection);
    else ind_f_l = inds_f(i+1)-1;
    end
    
    if(qd(ind_f) > numQuads/2),
        qd_unwrap(ind_f:ind_f_l) = cur_rots + qd(ind_f) - numQuads;
    else
        qd_unwrap(ind_f:ind_f_l) = cur_rots + qd(ind_f);
    end
    qd_unwrap(ind_f:ind_f_l) = qd_unwrap(ind_f:ind_f_l) + cumsum(qd_diff(ind_f:ind_f_l));
    
    
    if(qd_unwrap(ind_f_l) > 0)
        last_unwrap_m1 = (qd_unwrap(ind_f_l)-1);
        cur_rots = (last_unwrap_m1 - mod(last_unwrap_m1,numQuads));    
    elseif((qd_unwrap(ind_f_l) <= 0))
        last_unwrap_m1 = (-1*qd_unwrap(ind_f_l));
        cur_rots = (qd_unwrap(ind_f_l) + mod(last_unwrap_m1,numQuads));  
    else
        error('Unexpected unwrap value');
    end
end
qd_unwrap(qd_unwrap<=0) = qd_unwrap(qd_unwrap<=0)-1;

% ind_f = find(isabovebackgroundrejection,1,'first');
% qd_unwrap = ones(size(qd));
% if(qd(ind_f) > numQuads/2),
%     qd_unwrap(ind_f:end) = qd(ind_f) - numQuads;
% else
%     qd_unwrap(ind_f:end) = qd(ind_f);
% end
% qd_unwrap(ind_f:end) = qd_unwrap(ind_f:end) + cumsum(qd_diff(ind_f:end));
% qd_unwrap(qd_unwrap<=0) = qd_unwrap(qd_unwrap<=0)-1;


%%
if nargout>=1, varargout{1}= qd_diff; end
if nargout>=2, varargout{2}= qd_unwrap; end
end

