function [Xtr Ytr Xts Yts] = splitTrainTest(X, Y, test_per)

[m n] = size(X);

positives = sum(Y);
negatives = m - positives;

test_size = floor(m * test_per);
train_size = m - test_size;

pos_test_size = floor(positives * test_per);
pos_train_size = positives - pos_test_size;

neg_test_size = floor(negatives * test_per);
neg_train_size = negatives - neg_test_size;

Xtr = logical(zeros(train_size, n));
Ytr = logical(zeros(train_size, 1));
Xts = logical(zeros(test_size-1, n));
Yts = logical(zeros(test_size-1, 1));

Xtr(1:pos_train_size,:) = X(1:pos_train_size,:);
Xtr((pos_train_size+1):(pos_train_size+neg_train_size),:) = X((positives+1):(positives+neg_train_size),:);

Ytr(1:pos_train_size, 1) = 1;
Ytr((pos_train_size+1):(pos_train_size+neg_train_size), 1) = 0;

Xts(1:pos_test_size,:) = X((pos_train_size+1):(pos_train_size+pos_test_size),:);
Xts((pos_test_size+1):(pos_test_size+neg_test_size),:) = X((positives+neg_train_size+1):(positives+negatives),:);

Yts(1:pos_test_size,1) = 1;
Yts((pos_test_size+1):(pos_test_size+neg_test_size),1) = 0;

end