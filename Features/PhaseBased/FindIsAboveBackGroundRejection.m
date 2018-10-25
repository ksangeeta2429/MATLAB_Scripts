function isabovebackgroundrejection = FindIsAboveBackGroundRejection(Comp, background_rejection_series)
if ~exist('background_rejection_series','var') || isempty(background_rejection_series), background_rejection_series = 0; end
if numel(background_rejection_series)==1, background_rejection_series = background_rejection_series.*ones(size(Comp)); end

isabovebackgroundrejection = or(abs(real(Comp)) > background_rejection_series,abs(imag(Comp))>background_rejection_series);

end