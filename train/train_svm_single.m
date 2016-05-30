%% Machine Learning Online Class - Exercise 4 Neural Network Learning

%% Initialization
clear ; close all; clc;
warning off;

training_file = '10001_training_xy.mat';
testing_file = '10001_testing_xy.mat';
params_file = '10001_model_gaussian.str';

fprintf('Loading and Visualizing Data ...\n')

load(training_file);            % XTR + YTR
[m n] = size(Xtr);              % should be 15k, 10k

fprintf('Program paused. Press enter to continue.\n');
pause;

%  Optimal values from train_svm_opt.m
C = 1;
sigma = 10;

fprintf('\nTraining SVM... C = %5.2f; sigma = %5.2f\n', C, sigma);
model = svmTrain(Xtr, Ytr, C, @(x1, x2) gaussianKernel(x1, x2, sigma));

fprintf('Training completed. Press enter to continue.\n');
pause;

pred = svmPredict(model, Xtr);
fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == Ytr)) * 100);

showAccuracy(Ytr, pred);

load(testing_file);

[m n] = size(Xts);

pred_t = svmPredict(model, Xts);
fprintf('\nTesting Set Accuracy: %f\n', mean(double(pred_t == Yts)) * 100);

showAccuracy(Yts, pred_t);
pause;

save -z 'model.str' model;
rename('model.str', params_file);

rp = randperm(m);
for i = 1:m
    fprintf('\nDisplaying Example Image: %d\n', rp(i));
    displayData(Xts(rp(i), :));

    p = svmPredict(model, Xts(rp(i),:));
    fprintf('\nSVM Prediction : %d confidence %d %%)\n', p, 100);
    fprintf('\nTest set says it should be: %d\n', Yts(rp(i), 1));

    fprintf('Program paused. Press enter to continue.\n');
    pause;
end