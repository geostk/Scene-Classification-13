function [h] = getImageFeaturesSPM(layerNum, wordMap, dictionarySize)
% Compute histogram of visual words using SPM method
% Inputs:
%   layerNum: Number of layers (L+1)
%   wordMap: WordMap matrix of size (h, w)
%   dictionarySize: the number of visual words, dictionary size
% Output:
%   h: histogram of visual words of size {dictionarySize * (4^layerNum - 1)/3} (l1-normalized, ie. sum(h(:)) == 1)

    % TODO Implement your code here
l = layerNum - 1;
%hist_gram = zeros(1, dictionarySize);
hist_gram = zeros((dictionarySize * ((4^layerNum)-1)/3), 1);
cnt = 1;
while l >= 0
    weight = getWeightForLayer(l);
    sliceFactor = 2^l;
    imgHeightFactor = floor(size(wordMap,1)/sliceFactor);
    imgWidthFactor = floor(size(wordMap,2)/sliceFactor);
    for i = 1:sliceFactor
        for j = 1:sliceFactor
            heightSt = ((i-1)*imgHeightFactor) + 1;
            widthSt = ((j-1)*imgWidthFactor) + 1;
            heightEd = i*imgHeightFactor;
            widthEd = j*imgWidthFactor;
            slicedWordMap = wordMap(heightSt:heightEd, widthSt:widthEd);
            hist_sliced = getImageFeatures(slicedWordMap, dictionarySize);
            hist_sliced = weight * hist_sliced;
            hist_end = cnt * dictionarySize;
            hist_st = hist_end - dictionarySize + 1;
            hist_gram(hist_st:hist_end, 1) = hist_sliced;
            cnt = cnt+1;
        end
    end
    l = l-1;
end
sum_hist = sum(hist_gram);
h = hist_gram/sum_hist;

end

function [w] = getWeightForLayer(l)
if l == 0 || l == 1
    w = 0.25;
else
    w = 0.5;
end
end