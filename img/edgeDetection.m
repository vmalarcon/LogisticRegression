function image_result = edgeDetection(image_source)
	fprintf('Resizing...\n');
	imr = imresize(image_source, [70 70]);
	fflush(stdout);

	fprintf('Converting to grayscale...\n');
	imgrg = rgb2gray(imr);
	fflush(stdout);

	fprintf('Edge detection...\n');
	ime = edge(imgrg);
	fflush(stdout);

	image_result = ime;
end