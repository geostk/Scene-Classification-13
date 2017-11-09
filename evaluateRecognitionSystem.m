function [conf] = evaluateRecognitionSystem()
% Evaluates the recognition system for all test-images and returns the confusion matrix

	load('vision.mat');
	load('../data/traintest.mat');
    load('dictionary.mat');

	% TODO Implement your code here
    C = zeros(length(mapping));
    for itr = 1:length(test_imagenames)
        i = test_labels(itr); %correct class
        img_name = test_imagenames{itr};
        j = guessImage_returnsNum(['../data/',img_name], dictionary, filterBank, train_features, train_labels);
        C(i,j) = C(i,j) + 1;
    end
    disp(C);
    conf = trace(C)/sum(C(:));
   

end