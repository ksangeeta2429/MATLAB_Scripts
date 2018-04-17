%get number of instances for each count label

function [xx,t] = labelCount(test_true_labels)
	xx = unique(test_true_labels);
    x = sort(test_true_labels);
    t = zeros(size(xx));
    for i = 1:length(xx)
        t(i) = sum(x == xx(i));
    end
end