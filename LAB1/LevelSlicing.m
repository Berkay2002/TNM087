function [RGB_Range, IR_Select] = LevelSlicing( RGB_Image, IR_Image, LevelRange)
%function GImage = LevelSlicing( RGB_Image, IR_Image, LevelRange )

%   Implement intensity level slicing on an RGB-image, with the range defined from an IR-image:
%   Slect a reference intensity value from the IR image
%   Compute the range of intensity levels of interest 
%   Use the defined intensity range from the IR-image to Mask out the corresponding areas in the RGB-image
%   the result is the double image GImage with maximum gray value one
%
%% Who has done it
%
% Authors: beror658
%
%% Syntax of the function
%
%   Input arguments:
%       RGB_Image: RGB color image of type uint8 or double
%       IR_Image: Infrared intensity image of type uint8, uint16 or double
%       LevelRange: The range of intensity levels to select (defined in % of total intensity range)
%   Output argument: 
%       RGB_Range: RGB image of type double, displaying the selected intensity range
%       IR_Select: RGB image of type double, displaying the position of the
%       selected pixel in the IR-image

% You MUST NEVER change the first line
%
%% Basic version control (in case you need more than one attempt)
%
% Version: 1
% Date: 2023-11-06
%
% Gives a history of your submission to Lisam.
% Version and date for this function have to be updated before each
% submission to Lisam (in case you need more than one attempt)
%
%% General rules
%
% 1) Don't change the structure of the template by removing %% lines
%
% 2) Document what you are doing using comments
%
% 3) Before submitting make the code readable by using automatic indentation
%       ctrl-a / ctrl-i
%       
% 4) Often you must do something else between the given commands in the
%       template
%
%% Image size and image class handling
%
[nr,nc,nch] = size(RGB_Image); % Number of rows, columns and channels in the image

% Convert images to double for processing
RGB_Image = im2double(RGB_Image);
IR_Image = im2double(IR_Image);

%% Show the IR image to select a pixel with reference intensity value

fh1 = figure; 
imshow(IR_Image);
set(fh1,'NumberTitle','off','Name','Select a pixel for reference intensity level')
[x,y] = ginput(1); % x and y are the coordinates of the reference pixel 
close(fh1); % Close the figure once the input is taken

% Note that x and y are not the same as row and column! 
% Refer to the help-section for the function ginput for reference

%% Find the selected intensity range from the IR image
% Based on the coordinates of the selected pixel (expressed in x,y )
% find the selected intensity level. Then compute the selected intensity range,
% based on the vaiable LevelRange

% Round to integer
x = round(x);
y = round(y);

% Compute intensity range
Lower = IR_Image(y,x) - (LevelRange/200); 
Higher = IR_Image(y,x) + (LevelRange/200);

%% Mask out the areas ine th RGB image, based on the selected intensity range in the IR image
% Compute a Mask (binary image) from the IR image, which is ONE only where IR<Higher & IR>Lower

Mask = IR_Image <= Higher & IR_Image >= Lower;
            
Mask3 = cat(3, Mask, Mask, Mask);


% Use the Mask to Mask out the areas within ths selected IR-range in the RGB-images
% (for all 3 color channels)
RGB_Range = RGB_Image.*Mask3; % Start with a copy of the RGB_Image




%% Show the selected pixel in the IR-image
% Crete an image that shows the position of the selected pixel in the IR-image, using a red mark.
% Marking just a sngle pixel is difficult to see in the image. Use at least a 5x5 pixel area 
% if you use a square. You can also consider marking the pixel with a cross, or some other shape
%

IR_Select = cat(3, IR_Image, IR_Image, IR_Image);


% This create an RGB image. Since the color channels are identical, it will
% be displayed in grayscale. 
% Now modify IR_select to mark the selected pixel in red!

markSize = 5; % Define the size of the mark
xmin = max(x - markSize, 1);
xmax = min(x + markSize, nc);
ymin = max(y - markSize, 1);
ymax = min(y + markSize, nr);

IR_Select(ymin:ymax, xmin:xmax, 1) = 1; % Red channel
IR_Select(ymin:ymax, xmin:xmax, 2:3) = 0; % Green and Blue channels set to 0 for red color
    
%% Display the result
% The result is displayed. Use the following names and formats:
% RGB_Image - Input RGB image (3 channels)
% RGB_Range - Output RGB image, displaying the selected range (3 channels)
% IR_Select - Output image showing the selected pixel position (3 channels)
% Mask - Binary image marking the selected intensity range in IR_Image (1 channel)

fh2 = figure;
montageImage = zeros(nr, nc, nch, 4);
montageImage(:,:,:,1) = RGB_Image;
montageImage(:,:,:,2) = RGB_Range;
montageImage(:,:,:,3) = IR_Select;
montageImage(:,:,:,4) = cat(3, Mask, Mask, Mask);

montage(montageImage)
title('RGB / RGB: Selected Range / IR: Selected Pixel / IR: Mask');
set(fh2,'NumberTitle','off','Name','Level Slicing Result');

%% Debugging



end

