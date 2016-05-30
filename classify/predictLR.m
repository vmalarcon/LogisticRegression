function [p] = predictLR(all_theta, X)

[m n] = size(X);

% You need to return the following variables correctly 
p = zeros(m, 1);

% Add ones to the X data matrix
X = [ones(m, 1) X];

p = sigmoid(X * all_theta');

end
