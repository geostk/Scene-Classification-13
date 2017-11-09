function [filterBank, dictionary] = getFilterBankAndDictionary(imPaths)
% Creates the filterBank and dictionary of visual words by clustering using kmeans.

% Inputs:
%   imPaths: Cell array of strings containing the full path to an image (or relative path wrt the working directory.
% Outputs:
%   filterBank: N filters created using createFilterBank()
%   dictionary: a dictionary of visual words from the filter responses using k-means.

    disp('Inside getFilterBankAndDictionary :::: ');
    disp(length(imPaths));
    alpha = 100;

    filterBank  = createFilterBank();
    kmeans_mtx = zeros(alpha*length(imPaths), 60);
    alpha_row_cnt = 1;
    
    for i = 1:length(imPaths)
        imPath = imPaths{1};
        img = imread(imPath);
        fRs = extractFilterResponses(img, filterBank);
        pixels = randperm(size(img,1)*size(img,2), alpha);
        for j = 1:60
            fr = fRs(:,:,j);
            alpha_row_cnt = ((i-1)*100)+1;
            for pixel = pixels
                kmeans_mtx(alpha_row_cnt, j) = fr(pixel);
                alpha_row_cnt = alpha_row_cnt + 1;
            end
        end
    end

    k = 100;
    [~ , dictionary] = kmeans(kmeans_mtx, k, 'EmptyAction', 'drop');
    dictionary = dictionary';
end
