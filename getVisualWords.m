function [wordMap] = getVisualWords(img, filterBank, dictionary)
% Compute visual words mapping for the given image using the dictionary of visual words.

% Inputs:
% 	img: Input RGB image of dimension (h, w, 3)
% 	filterBank: a cell array of N filters
% Output:
%   wordMap: WordMap matrix of same size as the input image (h, w)

% TODO Implement your code here


fR = extractFilterResponses(img, filterBank);
fR_flattened = zeros(size(img, 1)*size(img, 2), 60);
for i = 1:60
    filter = fR(:,:,i);
    filter_flattened = reshape(filter,[],1);
    fR_flattened(:,i) = filter_flattened;
end

dictT = dictionary';
dist_result = pdist2(fR_flattened, dictT, 'euclidean');
[~, min_idx] = min(dist_result, [], 2);

wordMap = reshape(min_idx, size(img, 1), size(img, 2));

end
