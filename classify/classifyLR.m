%% Machine Learning Online Class

%% Initialization
clear ; close all; clc;
warning off;

threshold = 0.5

load('all_theta.mat');

%  Randomly permute examples
load('testing_x_4900.mat');
[m n] = size(XTS);
YTS = YTS == 1;

per = predictLR(all_theta, XTS);
p = per > threshold;
fprintf('\nTesting Set Accuracy: %f\n', mean(double(p == YTS)) * 100);
fprintf('\nImgs identified within confidence: %f %%(total for the category %f %%)\n', (sum(p) / size(p, 1)) * 100, (sum(YTS) / size(YTS, 1)) * 100);
pause;

rp = randperm(m);
for i = 1:m
    % Display 
    fprintf('\nDisplaying Example Image: %d\n', rp(i));
    displayData(XTS(rp(i), :));

    per = predictLR(all_theta, XTS(rp(i),:));
    p = per > threshold;
    fprintf('\nLogistic Regression Prediction: %d (LIV_ROOM) confidence = %d %%)\n', p, per * 100);
    
    % Pause
    fprintf('Program paused. Press enter to continue.\n');
    pause;
end