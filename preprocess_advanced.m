img = niblack(rgb2gray(imread('11_002.png')), [25 25], -0.2, 10);

noiseless_img = img;
figure, imshow(img);
[rows, columns] = size(noiseless_img);

Y = [];
X = [];
% go across columns of image looking for last white pixel in the column.
for col = 1 : columns
    column_data = noiseless_img(:,col);
    lowermost_pixel = find(column_data == 0, 1, 'last')
    if isempty(lowermost_pixel)
        display('Empty column found')
    else
        display('Non empty column found')
        X = [X; col];
        Y = [Y; lowermost_pixel];
    end
end

noiseless_img = ~noiseless_img;
% noiseless_img = bwmorph(noiseless_img,'thin',inf );
noiseless_img = ~noiseless_img;

figure, imshow(noiseless_img);
hold on

p = polyfit(X, Y, 1)
plot(X,Y,'*',1:0.1:230,polyval(p,1:0.1:230),'-')

angle = atan(p(1))*(-1);
angle_deg = radtodeg(atan(p(1))*(-1))

% projective transformation
cosine = cos(angle)
sine = sin(angle)
A = [cosine sine 0; (-1)*sine cosine 0; 0 0 1]

T = projective2d(A);
rotated_img = imwarp(noiseless_img, T);
rotated_img = ~rotated_img;
rotated_img = imclearborder(rotated_img);
rotated_img = ~rotated_img;

rotated_img_with_noise = rotated_img;


rotated_img = ~rotated_img;
rotated_img = imclearborder(rotated_img,4);
rotated_img = bwareaopen(rotated_img, 50);
rotated_img = ~rotated_img;

[row, column] = find(rotated_img == 0);
cropped_img = imcrop(rotated_img_with_noise, [min(column), min(row), (max(column) - min(column)), (max(row) - min(row))]);

[h w] = size(cropped_img);

if w > h
    height = (h/w)*270
    resized = imresize(cropped_img, [height 270]);
else
    width = (w/h)*270
    resized = imresize(cropped_img, [270 width]);  
end
%resized = imresize(cropped_img, [270 270]);
[h_ w_] = size(resized)
r = addborder(resized, 3, 255, 'outer');

% r = ~r;
% r = bwmorph(r,'thin',inf );
% r = ~r;
[m n] = size(r);
p = 277;
q = 277;

K_pad = padarray(r, [floor((p-m)/2) floor((q-n)/2)], 'replicate','post');
K_pad = padarray(K_pad, [ceil((p-m)/2) ceil((q-n)/2)], 'replicate','pre');

size(K_pad)
K_pad = imopen(K_pad, strel('disk',1));
% K_pad = ~K_pad;
% K_pad = bwmorph(K_pad,'thin',inf );
% K_pad = ~K_pad;

% remove some of the noisy edges in the mask.


figure, imshow(K_pad);
