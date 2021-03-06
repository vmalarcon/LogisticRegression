function showThresholds(Yts, P)

ps = zeros(size(Yts,1),2);
ps(:,1) = Yts;

threshold = [0.5 0.6 0.7 0.8 0.9];
threshold_percents = zeros(4, size(threshold, 2));

ratio = sum(Yts) / size(Yts, 1);
fprintf('\nPositive/Negative ratio: %5.2f%% on %d samples\n', ratio * 100, size(Yts,1));
for t = 1:size(threshold, 2)
	pred = P > threshold(t);
	
	ps(:,2) = pred;

	threshold_percents(1, t) = mean((ps(:,1) == 1) & (ps(:,2) == 1));
	threshold_percents(2, t) = mean((ps(:,1) == 0) & (ps(:,2) == 0));
	threshold_percents(3, t) = mean((ps(:,1) == 0) & (ps(:,2) == 1));
	threshold_percents(4, t) = mean((ps(:,1) == 1) & (ps(:,2) == 0));

	fprintf('\nThreshold=%5.2f: [Accuracy(TP+TN)=%5.2f] [TP=%5.2f] [TN=%5.2f] [FP=%5.2f] [FN=%5.2f]\n', threshold(t), mean(double(pred == Yts)) * 100, threshold_percents(1, t) * 100, threshold_percents(2, t) * 100, threshold_percents(3, t) * 100, threshold_percents(4, t) * 100);
end

end