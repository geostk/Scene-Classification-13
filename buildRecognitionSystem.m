function buildRecognitionSystem()
% Creates vision.mat. Generates training features for all of the training images.

	load('dictionary.mat');
	load('../data/traintest.mat');

	% TODO create train_features
    train_features = [];

    for i = 1:length(train_imagenames)
        img_path = train_imagenames{i};
        wordmap_path = strrep(img_path, '.jpg', '.mat');
        load(['../data/', wordmap_path]);
        hist_image = getImageFeaturesSPM(3, wordMap, size(dictionary, 2));
        train_features(:, i) = hist_image;
    end
    train_labels = train_labels';
        
	save('vision.mat', 'filterBank', 'dictionary', 'train_features', 'train_labels');

end