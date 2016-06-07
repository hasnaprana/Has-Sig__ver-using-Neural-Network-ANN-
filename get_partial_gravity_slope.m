function  slope= get_partial_gravity_slope(image)

img =image;
[height width] = size(img);

[row_, column_] = find(img == 0);

x_centroid = sum(column_)/ size(column_, 1);
y_centroid = sum(row_)/ size(row_, 1);

% crop the image into two portions
left_crop = imcrop(img, [0, 0, x_centroid, height]);
right_crop = imcrop(img, [x_centroid, 0, (width - x_centroid), height]);

% figure;imshow(left_crop); %hold on;
% figure;imshow(right_crop); %hold on;
% get centroid of the left portion
[row, column] = find(left_crop == 0);
left_crop_x_centroid = sum(column)/ size(column, 1);
left_crop_y_centroid = sum(row)/ size(row, 1);

%get centroid of the right portion
[row, column] = find(right_crop == 0);
right_crop_x_centroid = sum(column)/ size(column, 1) + x_centroid;
right_crop_y_centroid = sum(row)/ size(row, 1);

%get slope 
X = [left_crop_x_centroid; right_crop_x_centroid];
Y = [left_crop_y_centroid; right_crop_y_centroid];
p = polyfit(X, Y, 1);

% figure;imshow(img); hold on;
% plot(X,Y,'*',1:0.1:230,polyval(p,1:0.1:230),'-')
slope = radtodeg(atan(p(1))*(-1));