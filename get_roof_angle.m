function  angle_deg= get_roof_angle(image)

img = niblack(rgb2gray(image), [25 25], -0.2, 10);
noiseless_img = img;

[rows, columns] = size(noiseless_img);

Y = [];
X = [];
% go across columns of image looking for last white pixel in the column.
for col = 1 : columns
    column_data = noiseless_img(:,col);
    uppermost_pixel = find(column_data == 0, 1, 'first');
    if ~isempty(uppermost_pixel)
        %display('Non empty column found')
        X = [X; col];
        Y = [Y; uppermost_pixel];
    %else
        %display('Empty column found')
    end
end

noiseless_img = ~noiseless_img;
noiseless_img = bwmorph(noiseless_img,'thin',inf );
noiseless_img = ~noiseless_img;

% figure, imshow(noiseless_img);
% hold on

p = polyfit(X, Y, 1);
% plot(X,Y,'*',1:0.1:230,polyval(p,1:0.1:230),'-');

angle = atan(p(1))*(-1);
angle_deg = radtodeg(atan(p(1))*(-1));