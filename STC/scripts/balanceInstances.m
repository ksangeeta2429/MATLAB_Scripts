%This script is used to uniformly balance instances with respect to class label

function [balanced] = balanceInstances(data,seed,perc)

import weka.core.Instances;
import weka.filters.supervised.instance.Resample;

rs = Resample();
options = sprintf('-S %d -no-replacement -B %d -Z %d',seed,1,perc);
rs.setOptions(weka.core.Utils.splitOptions(options));
rs.setInputFormat(data);
balanced = Filter.useFilter(data, rs);

end