%% Machine Learning Online Class - Exercise 4 Neural Network Learning

%% Initialization
clear ; close all; clc;
warning off;

input_layer  = 4900;
inner_layer  = 200;
output_layer = 1;

% Load Training Data
fprintf('Loading NN params Data ...\n')

T1s = zeros(5, inner_layer * (input_layer + 1));
T2s = zeros(5, output_layer * (inner_layer + 1));

load '21001_weights.mat';
T1s(1) = Theta1(:);
T2s(1) = Theta2(:);

load '23000_weights.mat';
T1s(2) = Theta1(:);
T2s(2) = Theta2(:);

load '22005_weights.mat';
T1s(3) = Theta1(:);
T2s(3) = Theta2(:);

load '10001_weights.mat';
T1s(4) = Theta1(:);
T2s(4) = Theta2(:);

load '81003_weights.mat';
T1s(5) = Theta1(:);
T2s(5) = Theta2(:);

threshold = 0.6

load(params_file);
load(testing_file);

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
