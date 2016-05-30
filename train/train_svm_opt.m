%% Machine Learning Online Class

clear ; close all; clc;
warning off;

fprintf('Loading Data ...\n');

training_file = '10001_small_training_xy.mat';
cval_file = '10001_val_xy.mat';

load(training_file);
load(cval_file);

fprintf('Program paused. Press enter to continue.\n');
pause;

[C sigma] = dataset3Params(Xstr, Ystr, Xval, Yval);

fprintf('\nOptimal values for SVM C = %5.2f; sigma = %5.2f\n', C, sigma);
pause;