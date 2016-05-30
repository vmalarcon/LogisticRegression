function showAccuracy(Yts, P)

tp = mean(double((Yts == 1) & (P == 1)));
tn = mean(double((Yts == 0) & (P == 0)));
fp = mean(double((Yts == 0) & (P == 1)));
fn = mean(double((Yts == 1) & (P == 0)));

fprintf('\n[Accuracy(TP+TN)=%5.2f] [TP=%5.2f] [TN=%5.2f] [FP=%5.2f] [FN=%5.2f]\n', mean(double(P == Yts)) * 100, tp * 100, tn * 100, fp * 100, fn * 100);

end