%% Machine Learning Online Class - Exercise 4 Neural Network Learning

%% Initialization
clear ; close all; clc;
warning off;

testing_file = '23000_testing_xy.mat';
params_file = '23000_weights.mat';

% Load Training Data
fprintf('Loading and Visualizing Data ...\n')

threshold = 0.8

load(params_file);
load(testing_file);

%Xts = X;
%Yts = Y;

[m n] = size(Xts);

[pred_t, mv_t] = predictNN(Theta1, Theta2, Xts);
pred_t = mv_t > threshold;
fprintf('\nTesting Set Accuracy: %f\n', mean(double(pred_t == Yts)) * 100);

ps = zeros(size(Yts,1),2);
ps(:,1) = Yts;
ps(:,2) = pred_t;
fprintf('\nTrue positives : %f', mean((ps(:,1) == 1) & (ps(:,2) == 1)) * 100);
fprintf('\nTrue negatives : %f', mean((ps(:,1) == 0) & (ps(:,2) == 0)) * 100);
fprintf('\nFalse positives: %f', mean((ps(:,1) == 0) & (ps(:,2) == 1)) * 100);
fprintf('\nFalse negatives: %f', mean((ps(:,1) == 1) & (ps(:,2) == 0)) * 100);
showThresholds(Yts, mv_t);
pause;

rp = randperm(m);
for i = 1:m
    [p, per] = predictNN(Theta1, Theta2, Xts(rp(i),:));
    p = per > threshold;

    if (p != 1) 
    	fprintf('.');
    	continue;
    endif

    fprintf('\nDisplaying Example Image: %d\n', rp(i));
    displayData(Xts(rp(i), :));

    fprintf('\nNeural Network Prediction : %d confidence %d %%)\n', p, per * 100);
    fprintf('\nLCM says it should be     : %d\n', Yts(rp(i), 1));

    fprintf('Program paused. Press enter to continue.\n');
    pause;
end
