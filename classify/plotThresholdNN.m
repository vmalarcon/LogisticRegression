%% Machine Learning Online Class - Exercise 4 Neural Network Learning

%% Initialization
clear ; close all; clc;
warning off;

testing_file = '23000_testing_xy.mat';
params_file = '23000_weights.mat';

% Load Training Data
fprintf('Plotting threshold values ...\n')

load(params_file);
load(testing_file);

[m n] = size(Xts);

ps = zeros(size(Yts,1),2);
ps(:,1) = Yts;

[pred_t, mv_t] = predictNN(Theta1, Theta2, Xts);

threshold = [0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9];
threshold_percents = zeros(3, size(threshold, 2));

for t = 1:size(threshold, 2)
	pred_t = mv_t > threshold(t);
	
	ps(:,2) = pred_t;

	threshold_percents(1, t) = mean((ps(:,1) == 1) & (ps(:,2) == 1)) + mean((ps(:,1) == 0) & (ps(:,2) == 0));
	threshold_percents(2, t) = mean((ps(:,1) == 0) & (ps(:,2) == 1));
	threshold_percents(3, t) = mean((ps(:,1) == 1) & (ps(:,2) == 0));

	fprintf('\nThreshold=%5.2f: [Accuracy(TP+TN)=%5.2f] [FP=%5.2f] [FN=%5.2f]\n', threshold(t), mean(double(pred_t == Yts)) * 100, threshold_percents(2, t) * 100, threshold_percents(3, t) * 100);
end

plot(threshold, threshold_percents);
xlabel('Threshold');
ylabel('Accuracy');