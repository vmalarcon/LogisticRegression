function [X Y] = loadImagesFromURL(imgs, positives, p)

m = length(imgs);

tmpName = strcat(tmpnam(), '.jpg');

% Detect the number of pixels of the first image
imgUrl = imgs(1){1,1};
urlwrite(imgUrl, tmpName);
im = imread(tmpName);
img = feval(p, im);

n = size(img(:)', 2);

% Dim the return matices properly
X = logical(zeros(m, n));
Y = logical(zeros(m, 1));

% Load the urls
idx = 1;
for i = 1:m
	imgUrl = imgs(i){1,1};

	try
		fprintf('Fetching %s:\n', imgUrl);
		urlwrite(imgUrl, tmpName);
		fflush(stdout);

		fprintf('Loading...\n');
		im = imread(tmpName);
		fflush(stdout);

		fprintf('Processing...\n');
		img = feval(p, im);
		fflush(stdout);

		fprintf('Adding image: %d...\n', i);
		X(idx, :) = img(:)';
		Y(idx, 1) = (i <= positives);
		idx = idx + 1;
		fflush(stdout);
	catch
		fprintf('Failed %s. Skipping...\n', imgUrl);
		fflush(stdout);
	end
end

% idx contain the 'actual' number of images downloaded, trim the remaining rows
idx = idx - 1;
X = X(1:idx,:);
Y = Y(1:idx,:);

% Cleanup
delete(tmpName);

end