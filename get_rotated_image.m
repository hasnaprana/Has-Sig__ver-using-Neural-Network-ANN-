function  rotated_img= get_rotated_image(image)

img = niblack(rgb2gray(image), [25 25], -0.2, 10);
noiseless_img = img;

[rows, columns] = size(noiseless_img);

Y = [];
X = [];
% go across columns of image looking for last white pixel in the column.
for col = 1 : columns
    column_data = noiseless_img(:,col);
    lowermost_pixel = find(column_data == 0, 1, 'last');
    if ~isempty(lowermost_pixel)
        %display('Non empty column found');
        X = [X; col];
        Y = [Y; lowermost_pixel];
    %else
    %    display('Empty column found');
    end
end

noiseless_img = ~noiseless_img;
noiseless_img = bwmorph(noiseless_img,'thin',inf );
noiseless_img = ~noiseless_img;

%figure;imshow(noiseless_img);hold on;

p = polyfit(X, Y, 1);
%plot(X,Y,'*',1:0.1:230,polyval(p,1:0.1:230),'-')

angle = atan(p(1))*(-1);
% angle_deg = radtodeg(atan(p(1))*(-1));

% projective transformation
cosine = cos(angle);
sine = sin(angle);
A = [cosine sine 0; (-1)*sine cosine 0; 0 0 1];

T = projective2d(A);
rotated_img = imwarp(noiseless_img, T);
rotated_img = ~rotated_img;
rotated_img = imclearborder(rotated_img);
rotated_img = ~rotated_img;



