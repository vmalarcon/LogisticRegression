function [X, Y] = loadImagesFromDir(directory, mmax, label)

X = zeros(mmax, 4900);
Y = zeros(mmax, 1);

list = ls(directory);
[m, n] = size(list);

for i = 1:mmax
	try
		file = strcat(directory, '/', list(i,:));
		fprintf('Reading %s:\n', file);
		im = imread(file);
		fflush(stdout);

		fprintf('Resizing...\n');
		imr = imresize(im, [70 70]);
		fflush(stdout);

		fprintf('Converting to grayscale...\n');
		imgr = rgb2gray(imr);
		fflush(stdout);

		fprintf('Normalizing...\n');
		imgrd = double(imgr);
		imgrn = imgrd / 256.0;
		fflush(stdout);

		fprintf('Adding image: %d...\n', i);
		X(i, :) = imgrn(:)';
		Y(i, 1) = label;
		fflush(stdout);
	catch
		fprintf('Failed %s. Skipping...\n', list(i,:));
		fflush(stdout);
	end
end