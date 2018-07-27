function haar_feature_test(Data,levels)
% haar_feature_test
% verify new haar_feature (that works with MATLAB 2016) computes the same
% value as the original haar_feature
%
% created: 2018-07-27 Michael McGrath <mcgrath.57@osu.edu>

test_old = haar_feature_orig(Data,levels)
test_new = haar_feature(Data,levels)

figure;
plot(1:length(test_old),test_old,1:length(test_old),imag(test_old), ...
      1:length(test_new),real(test_new),1:length(test_new),imag(test_new));
 str_legend{1} = 'old real';
 str_legend{2} = 'old imag';
 str_legend{3} = 'new real';
 str_legend{4} = 'new imag';
 legend(str_legend);

%TODO: for automated test, compare test_old to test_new.
