function [centroid] = find_centroid(pixels, height, width)
% Function to find the centroid for
% A given map of pixels, assuming that it's a rectangle. If it's 
% Not a rectangle, then cry and hope for the best
% No but seriously, it should always be a rectangle as 
% The environment is very controlled and should be efficient to filter out
% noise

first1found = 0;
skipRows = 50;
top_left = [-1 -1];
bot_right = [-1 -1];
i = 0;
while i < height
    for j = 1:width
        if pixels(i,j) == 1
            if ~first1found
%               Skip an arbitrary amount of rows
%               To avoid running into any issues with "stray" pixels
                i = i + skipRows;
                first1found = 1;
            else 
                if top_left == [-1, -1]
                    top_left = [i, j];
                end 
                if bot_right(1) <= i && bot_right(2) <= j
                    bot_right = [i,j];
                end 
            end 
        end 
    end
    i = i + 1;
end 

% Calculate the centroid
centroid = [top_left(1) + floor((bot_right(1)- top_left(1))/2) , top_left(2) + floor((bot_right(2)- top_left(2))/2)];








