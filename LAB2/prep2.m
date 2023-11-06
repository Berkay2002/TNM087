%problem 1
img = imread('TestPattern.tif');
img = im2double(img); % Scale the image
boxKernel = fspecial('average', [9 9]);
Image1 = imfilter(img, boxKernel, 'replicate');
imshow(Image1);
title('Problem 1');
imwrite(Image1, 'Image1.png');

%problem 2
boxKernel = fspecial('average', [21 21]);
Image2 = imfilter(img, boxKernel, 'replicate');
imshow(Image2);
title('Problem 2');
imwrite(Image2, 'Image2.png');

% Image2 is more blurred than Image1 because a 21x21 kernel has a 
% larger area, hence it averages over a larger number of pixels, 
% effectively reducing high-frequency content more than a 9x9 kernel, 
% indicating a lower cutoff frequency.

% The dark borders are due to the convolution not handling the 
% borders well. By default, the imfilter function handles borders
% by padding with zeros, which can cause dark borders in the output.

%problem 5
Image3 = imfilter(img, boxKernel, 'symmetric');
imshow(Image3);
title('Problem 5');
imwrite(Image3, 'Image3.png');

%problem 6
deltaKernel = zeros(21, 21);
deltaKernel(11, 11) = 1; % Center pixel has a value of 1
highpassKernel = deltaKernel - boxKernel;
Image4 = imfilter(img, highpassKernel, 'replicate');
imshow(Image4);
title('Problem 6');
imwrite(Image4, 'Image4.png');

% Image4 is dark because highpass filtering typically results in values 
% that are both positive and negative. When these values are scaled to 
% the displayable range of [0,1] for images, they are biased to be 
% around 0.5. The average value of the pixel values in Image4 should 
% be around 0.5 after properly scaling the pixel values to 
% the displayable range.

%problem 8
Image5 = img + Image4; % You may need to scale Image4 before adding
imshow(Image5);
title('Problem 8');
imwrite(Image5, 'Image5.png');

% Problem 9
img = imread('TestPattern.tif');
Sobx = [-1 -2 -1; 0 0 0; 1 2 1]; % Sobel kernel for x-direction
Gx = filter2(Sobx, img); % Applying Sobel filter in x-direction
imwrite(Gx, 'Image6.png'); % Save the result

% Problem 10
Soby = [-1 0 1; -2 0 2; -1 0 1]; % Sobel kernel for y-direction
Gy = filter2(Soby, img); % Applying Sobel filter in y-direction
imshow("Image7.png");
title('Problem 2');
imwrite(Gy, 'Image7.png'); % Save the result

% Problem 11
% Calculate the magnitude of the gradient
G = sqrt(Gx.^2 + Gy.^2);
G = mat2gray(G); % Normalize the gradient image for display purposes
imwrite(G, 'Image8.png'); % Save the gradient image

