
function [foundBlue, foundYellow, centroid] = imageRecognition(image)

% Function for the DoBartender which takes an image and returns 
% the centroid of the blue or yellow rectangle found in the image,
% assuming it's found. If it's not found, returns False for both
% foundBlue and foundYellow

im_height = size(image,1);
im_width = size(image,2);


% Attempt to find either blue and yellow on the image
yellow_pixels = yellowmask(image);
blue_pixels = bluemask(image);

%Filter out noise with an arbitrary threshold of pixel
percentageThreshold = 0.03;
pixelThreshold = (im_height*im_width)*percentageThreshold;

yellow_counter = 0;
blue_counter = 0;

for i = 1:im_height
    for j = 1:im_width
        if yellow_pixels(i,j) == 1
            yellow_counter = yellow_counter +1;
        end 
        if blue_pixels(i,j) == 1
            blue_counter = blue_counter + 1;
        end 
    end 
end 

%Determine which one was found (if at all), and filter out the other one
%with noise
foundBlue = 0;
foundYellow = 0;

if blue_counter > pixelThreshold
    foundBlue = 1;
end 

if yellow_counter > pixelThreshold
    foundYellow = 1;
end 
%     This should not happen. Test for it though
assert(~(foundBlue && foundYellow), "Found both yellow and blue! This should not occur");

if foundYellow
%     Determine centroid for yellow
    centroid = find_centroid(yellow_pixels); 
elseif foundBlue
    centroid = find_centroid(blue_pixels);
else
%     No centroid found
    centroid = [-1 -1];
end 










