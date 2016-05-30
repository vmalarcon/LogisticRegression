%% Machine Learning Online Class

%% Initialization
clear ; close all; clc;
warning off;

% Load Training Data
fprintf('Loading and Visualizing Data ...\n')

load('21001_training_xy.mat');
[m n] = size(Xtr);           % should be 24k

fprintf('Program paused. Press enter to continue.\n');
pause;

lambda = 0.1;
fprintf('\nTraining Logistic Regression... lambda=%f\n', lambda);

if (exist('all_theta.mat', 'file'))
	fprintf('\nLoading Logistic Regression parameters... \n');
	load('all_theta.mat');
	initial_theta = all_theta;
else
	fprintf('\nInitializing Logistic Regression parameters... \n');
	initial_theta = zeros(1, n + 1);
endif

[all_theta] = trainLR(Xtr, Ytr, lambda, initial_theta);

fprintf('Program paused. Press enter to continue.\n');
pause;

save -z -mat 'all_theta.mat' all_theta;

threshold = 0.60

%% ================ Part 3: Predict for One-Vs-All ================
%  After ...
per = predictLR(all_theta, Xtr);
p = per > threshold;
fprintf('\nTraining Set Accuracy: %f\n', mean(double(p == Ytr)) * 100);

%  Randomly permute examples
load('21001_testing_xy.mat');
[m n] = size(Xts);

per = predictLR(all_theta, Xts);
p = per > threshold;
fprintf('\nTesting Set Accuracy: %f\n', mean(double(p == Yts)) * 100);
fprintf('\nTesting Set Confidence: %f\n', sum(p) / size(p, 1) * 100);

ps = zeros(size(Yts,1),2);
ps(:,1) = Yts;
ps(:,2) = p;
fprintf('\nTrue positives : %f\n', mean((ps(:,1) == 1) & (ps(:,2) == 1)) * 100);
fprintf('\nTrue negatives : %f\n', mean((ps(:,1) == 0) & (ps(:,2) == 0)) * 100);
fprintf('\nFalse positives: %f\n', mean((ps(:,1) == 0) & (ps(:,2) == 1)) * 100);
fprintf('\nFalse negatives: %f\n', mean((ps(:,1) == 1) & (ps(:,2) == 0)) * 100);
pause;

rp = randperm(m);
for i = 1:m
    fprintf('\nDisplaying Example Image: %d\n', rp(i));
    displayData(Xts(rp(i), :));

    per = predictLR(all_theta, Xts(rp(i),:));
    p = per > threshold;
    fprintf('\nLogistic Regression Prediction: %d confidence = %d %% (threshold = %f))\n', p, per * 100, threshold * 100);
    fprintf('\nTest set says it should be    : %d\n', Yts(rp(i), 1));
    
    % Pause
    fprintf('Program paused. Press enter to continue.\n');
    pause;
end
