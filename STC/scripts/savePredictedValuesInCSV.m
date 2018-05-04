function savePredictedValuesInCSV(true_labels,pred_result,file)
	rounded = round(pred_result);
	M = horzcat(true_labels',rounded,pred_result);
	csvwrite(file,M);
end