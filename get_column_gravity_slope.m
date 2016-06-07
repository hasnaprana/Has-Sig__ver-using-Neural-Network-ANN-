function  slope= get_column_gravity_slope(image)

img = image;
[rows, columns] = size(img);
Y = [];
X = [];
% go across columns of image looking for last white pixel in the column.
for col = 1 : columns
    column_data = img(:,col);
    color_pixels = find(column_data == 0);
    pixel_count = size(color_pixels, 1);
    if pixel_count > 0
        %display('Non empty column found');
        %calculate gravity center
        gravity_center = sum(color_pixels)/ pixel_count;
        X = [X; col];
        Y = [Y; gravity_center];
    end
end

p = polyfit(X, Y, 1);

% plot(X,Y,'*',1:0.1:230,polyval(p,1:0.1:230),'-')

angle = atan(p(1))*(-1);
slope = radtodeg(angle);
