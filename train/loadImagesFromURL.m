function [X Y] = loadImagesFromURL(imgs, positives)

m = length(imgs);

X = zeros(m, 4900);
Y = zeros(m, 1);

tmpName = strcat(tmpnam(), '.jpg');

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

		fprintf('Resizing...\n');
		imr = imresize(im, [70 70]);
		fflush(stdout);

		fprintf('Converting to grayscale...\n');
		imgrg = rgb2gray(imr);
		fflush(stdout);

		fprintf('Normalizing...\n');
		imgrd = double(imgrg);
		imgrn = imgrd / 256.0;
		fflush(stdout);

		fprintf('Adding image: %d...\n', i);
		X(idx, :) = imgrn(:)';
		Y(idx, 1) = (i <= positives);
		idx = idx + 1;
		fflush(stdout);
	catch
		fprintf('Failed %s. Skipping...\n', imgUrl);
		fflush(stdout);
	end
end

idx = idx - 1;
X = X(1:idx,:);
Y = Y(1:idx,:);

delete(tmpName);

end