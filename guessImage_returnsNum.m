function result = guessImage_returnsNum(imagename, dictionary, filterBank, train_features, train_labels)
    image = im2double(imread(imagename));

	% imshow(image);
	fprintf('[Getting Visual Words..]\n');
	wordMap = getVisualWords(image, filterBank, dictionary);
	h = getImageFeaturesSPM(3, wordMap, size(dictionary,2));
	distances = distanceToSet(h, train_features);
	[~,nnI] = max(distances);
    result = train_labels(nnI);
end