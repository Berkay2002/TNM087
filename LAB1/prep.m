clear;
%1a
Image = imread('book-cover.tif');
maxValue = max(Image(:));

%1b
Image2 = Image / 16;
maxValue2 = max(Image2(:));

%1c
imshow(Image2);

%1d
Image3 = Image2 * 16;
imshow(Image3);

%1e
imhist(Image3);

%1f
Image_double = im2double(Image);
imshow(Image_double);


%2a
img = imread('einstein-low-contrast.tif');

img_double = im2double(img);

min_val = min(img_double(:));
max_val = max(img_double(:));
fprintf('The min value is %f and the max value is %f.\n', min_val, max_val);

%2b
figure;
imhist(img_double);
title('Histogram of the Original Image');
saveas(gcf, 'original_histogram.png');

% Perform contrast stretching
K = 1; % Use 255 if you want the result in uint8 format
img_stretched = (img_double - min_val) * (K / (max_val - min_val));

figure;
imshow(img_stretched);
title('Contrast Stretched Image');

imwrite(img_stretched, 'stretched_image.png');

imhist(img_stretched);
title('Histogram of the Stretched Image');

min_val2 = min(img_stretched(:));
max_val2 = max(img_stretched(:));
fprintf('The min value is %f and the max value is %f.\n', min_val2, max_val2);



%3

mask_img = imread('angiography-mask-image.tif');
live_img = imread('angiography-live-image.tif');

mask_img_double = double(mask_img);
live_img_double = double(live_img);

diff_img_double = live_img_double - mask_img_double;

% contrast stretching to map the difference image 
min_diff = min(diff_img_double(:));
max_diff = max(diff_img_double(:));


K = 255; 
diff_img_stretched = (diff_img_double - min_diff) * (K / (max_diff - min_diff));

diff_img_stretched_uint8 = uint8(diff_img_stretched);

figure;
imshow(diff_img_stretched_uint8);
title('Enhanced Difference Image');

imwrite(diff_img_stretched_uint8, 'enhanced_difference_image.png');
fprintf('The min difference is %f and the max difference is %f.\n', min_diff, max_diff);

%4

pollen = imread('pollen-lowcontrast.tif');
imshow(pollen);
title('Original Low Contrast Image');

figure;
imhist(pollen);
title('Histogram of Original Image');

pollen_eq = histeq(pollen);

figure;
imshow(pollen_eq);
title('Histogram Equalized Image');

figure;
imhist(pollen_eq);
title('Histogram of Equalized Image');

% 5 A) 
shade_pattern = imread('Shade_pattern.tif');
shade_estimate = imread('Shade_estimate.tif');

figure, imshow(shade_pattern), title('Shaded Pattern Image');
figure, imhist(shade_pattern), title('Histogram of Shaded Pattern Image');

shade_estimate = double(shade_estimate);
shade_pattern = double(shade_pattern);

recovered_image = shade_pattern ./ shade_estimate;

recovered_image = mat2gray(recovered_image) * 255;

recovered_image = uint8(recovered_image);

imshow(recovered_image);
title('Recovered Image');

figure;
histogram(recovered_image);
title('Histogram of Recovered Image');

% Given the histogram, we get around 110-130 threshold value.
threshold = graythresh(recovered_image) * 255;

segmented_image = recovered_image > threshold;

figure;
imshow(segmented_image);
title('Segmented Image');


