function isabovebackgroundrejection = FindIsAboveBackGroundRejection(Comp, bgr)
%if ~exist('background_rejection_series','var') || isempty(background_rejection_series), background_rejection_series = 0; end
background_rejection_series = bgr.*ones(size(Comp));

isabovebackgroundrejection = or(abs(real(Comp)) > background_rejection_series,abs(imag(Comp))>background_rejection_series);

end