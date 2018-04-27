%given the true labels and predicted labels return the absolute errors and mean absolute errors
%for each of the labels

function [AE_rounded,MAE_rounded,AE,MAE,meanAbsError,meanAbsError_rounded] = absoluteAndMeanError(true_labels,pred_result,rounded_error)
%AE is absolute errors for diff count labels in test instances
AE = zeros(1,length(unique(true_labels)));
AE_rounded = zeros(1,length(unique(true_labels)));
n_AE = zeros(1,length(unique(true_labels)));
MAE = zeros(1,length(unique(true_labels)));
MAE_rounded = zeros(1,length(unique(true_labels)));
N = length(true_labels);
true_labels;
for i = 1:length(true_labels)
	AE(true_labels(i)) = AE(true_labels(i)) + abs(true_labels(i)-pred_result(i));
    if(rounded_error == 1)
        AE_rounded(true_labels(i)) = AE_rounded(true_labels(i)) + abs(true_labels(i)-round(pred_result(i)));
    end
    n_AE(true_labels(i)) = n_AE(true_labels(i)) + 1;
end
%MAE is mean absolute errors for diff count labels in test instances
for i = 1:length(true_labels)
    MAE(true_labels(i)) = AE(true_labels(i)) / n_AE(true_labels(i));
	MAE_rounded(true_labels(i)) = AE_rounded(true_labels(i)) / n_AE(true_labels(i));
end
AE;
MAE;
n_AE;
meanAbsError = 0; sum_AE = 0; sum_n = 0;
for i = 1:length(AE)
	sum_AE = sum_AE + AE(i);
	sum_n = sum_n + n_AE(i);
end
meanAbsError = sum_AE/sum_n;

meanAbsError_rounded = -1;
if(rounded_error == 1)
	 sum_AE_rounded = 0; sum_n_rounded = 0;
	for i = 1:length(AE)
		sum_AE_rounded = sum_AE_rounded + AE_rounded(i);
		sum_n_rounded = sum_n_rounded + n_AE(i);
	end
	meanAbsError_rounded = sum_AE_rounded/sum_n_rounded;
end

end