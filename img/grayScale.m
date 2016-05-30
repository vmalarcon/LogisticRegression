function image_result = grayScale(image_source)
	fprintf('Resizing...\n');
	imr = imresize(image_source, [70 70]);
	fflush(stdout);

	fprintf('Converting to grayscale...\n');
	imgrg = rgb2gray(imr);
	fflush(stdout);

	fprintf('Normalizing...\n');
	imgrd = double(imgrg);
	imgrn = imgrd / 256.0;
	fflush(stdout);

	image_result = imgrn;
end