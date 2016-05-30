function [all_theta] = trainLR(X, y, lambda, initial_theta)
% Some useful variables
[m n] = size(X);

% You need to return the following variables correctly 
% all_theta = zeros(num_labels, n + 1);
all_theta = initial_theta;

% Add ones to the X data matrix
X = [ones(m, 1) X];

start_theta = initial_theta';
options = optimset('GradObj', 'on', 'MaxIter', 50);
[theta] = fmincg(@(t)(lrCostFunction(t, X, y, lambda)), start_theta, options);
all_theta = theta';

end