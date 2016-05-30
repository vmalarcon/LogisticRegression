%% Machine Learning Online Class - Exercise 4 Neural Network Learning

%% Initialization
clear ; close all; clc;
warning off;

%% Setup the parameters you will use for this exercise
input_layer_size  = 4900;   % 70x70 Input Images of Digits
hidden_layer_size = 400;    % 100 hidden units
num_labels = 1;             % 10 labels, from 1 to 10   
                            % (note that we have mapped "0" to label 10)

training_file = '10001_training_xy.mat';
testing_file = '10001_testing_xy.mat';
params_file = '10001_weights.mat';

% Load Training Data
fprintf('Loading and Visualizing Data ...\n')

load(training_file);            % XTR + YTR
[m n] = size(Xtr);              % should be 15k, 10k

fprintf('Program paused. Press enter to continue.\n');
pause;

if (exist(params_file, 'file'))
  fprintf('\nLoading previous Neural Network Parameters ...\n');
  load(params_file);
  initial_Theta1 = Theta1;
  initial_Theta2 = Theta2;
else
  fprintf('\nInitializing Neural Network Parameters ...\n');
  initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
  initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);
endif

% Unroll parameters
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];

%  You should also try different values of lambda
lambda = 0.001;

fprintf('\nTraining Neural Network... lambda=%f \n', lambda);

%  After you have completed the assignment, change the MaxIter to a larger
%  value to see how more training helps.
options = optimset('MaxIter', 50);

% Create "short hand" for the cost function to be minimized
costFunction = @(p) nnCostFunction(p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, Xtr, Ytr, lambda);

% Now, costFunction is a function that takes in only one argument (the
% neural network parameters)
[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);

% Obtain Theta1 and Theta2 back from nn_params
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

fprintf('Training completed. Press enter to continue.\n');
pause;

threshold = 0.6

[pred, mv] = predictNN(Theta1, Theta2, Xtr);
pred = mv > threshold;
fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == Ytr)) * 100);

save -mat -z 'weights.mat' Theta1 Theta2;
rename('weights.mat', params_file);

load(testing_file);

[m n] = size(Xts);

[pred_t, mv_t] = predictNN(Theta1, Theta2, Xts);
pred_t = mv_t > threshold;
fprintf('\nTesting Set Accuracy: %f\n', mean(double(pred_t == Yts)) * 100);

showThresholds(Yts, mv_t);
pause;

rp = randperm(m);
for i = 1:m
    fprintf('\nDisplaying Example Image: %d\n', rp(i));
    displayData(Xts(rp(i), :));

    [p, per] = predictNN(Theta1, Theta2, Xts(rp(i),:));
    p = per > threshold;
    fprintf('\nNeural Network Prediction : %d confidence %d %%)\n', p, per * 100);
    fprintf('\nTest set says it should be: %d\n', Yts(rp(i), 1));

    fprintf('Program paused. Press enter to continue.\n');
    pause;
end