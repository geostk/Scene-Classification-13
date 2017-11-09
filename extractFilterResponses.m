function [filterResponses] = extractFilterResponses(img, filterBank)
% Extract filter responses for the given image.
% Inputs: 
%   img:                a 3-channel RGB image with width W and height H
%   filterBank:         a cell array of N filters
% Outputs:
%   filterResponses:    a W x H x N*3 matrix of filter responses


% TODO Implement your code here
img = double(img);
d3size = size(img, 3);
if d3size < 3
    imsize = size(img);
    new_image = zeros(imsize(1), imsize(2), 3);
    new_image(:,:,1) = img;
    new_image(:,:,2) = img;
    new_image(:,:,3) = img;
    Lab = RGB2Lab(new_image(:,:,1),new_image(:,:,2),new_image(:,:,3));
    %disp('Greyscale image');
else
    %disp('Truecolor image');
    Lab = RGB2Lab(img(:,:,1),img(:,:,2),img(:,:,3));
end
%Lab = RGB2Lab(img(:,:,1), img(:,:,2), img(:,:,3));
imgsize = size(Lab);
result = zeros(imgsize(1), imgsize(2), imgsize(3)*20);

for idx = 1:20
    %disp(idx);
    filter = filterBank{idx};
    filteredImage = imfilter(Lab, filter);
    ed = idx*3;
    st = ed-2;
    result(:, :, st:ed) = filteredImage;
end
filterResponses = result;
end
