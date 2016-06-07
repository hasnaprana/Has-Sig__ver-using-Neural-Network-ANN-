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

figure, imshow(noiseless_img); title('noiseless');
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
% rotated_img = imwarp(noiseless_img, T);
% rotated_img = ~rotated_img;
% rotated_img = imclearborder(rotated_img);
% rotated_img = ~rotated_img;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disk = strel('disk', 1);
%b = imdilate(~img, disk);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Image dilation thickens the image...                                %%%
%%% remove it to have a thin image, but change bwareaopen value below...%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%b = imdilate(~noiseless_img, disk);
%b = ~noiseless_img;
%figure, imshow(~b); title('dilated');
%rotated_img_ = imwarp(~b, T);

rotated_img_ = imrotate(~noiseless_img, angle);
%figure, imshow(rotated_img_); title('imwarp');
%rotated_img_ = imwarp(~noiseless_img, T);
%figure, imshow(rotated_img_); title('imwarp');
rotated_img_ = ~rotated_img_;

%rotated_img_ = imclearborder(rotated_img_);
%rotated_img_ = ~rotated_img_;

figure, imshow(rotated_img_); title('rotated');

rotated_img = rotated_img_;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rotated_img_with_noise = rotated_img;
%figure, imshow(rotated_img_with_noise); title('rotatedImgWithNoise');

rotated_img = ~rotated_img;
rotated_img = imclearborder(rotated_img,4);
%figure, imshow(rotated_img); title('imclearborder');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 50 for bwareaopen value is too much.                                %%%
%%% removes dots from the signature...                                  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rotated_img = bwareaopen(rotated_img, 5);
%rotated_img = bwareaopen(rotated_img, 50);
rotated_img = bwmorph(rotated_img, 'thicken', 1);
rotated_img = bwmorph(rotated_img, 'bridge');
rotated_img = ~rotated_img;
figure, imshow(rotated_img); title('bwareaopen');


[row, column] = find(rotated_img == 0);
cropped_img = imcrop(rotated_img, [min(column), min(row), (max(column) - min(column)), (max(row) - min(row))]);
%cropped_img = imcrop(rotated_img_with_noise, [min(column), min(row), (max(column) - min(column)), (max(row) - min(row))]);

%figure, imshow(cropped_img); title('croppedImg');

[h w] = size(cropped_img);

cropped_img = 255 * uint8(cropped_img);
cropped_img = imresize(cropped_img, [h * 2, NaN], 'Antialiasing', true);
figure, imshow(cropped_img); title('gray croppedImg');

if w > h
    height = (h/w)*270
    resized = imresize(cropped_img, [height 270]);
    %resized = imresize(cropped_img, [height 270], 'Antialiasing', true);
    %resized = imresize(cropped_img, [NaN 270], 'Antialiasing', true);
else
    width = (w/h)*270
    resized = imresize(cropped_img, [270 width]);
    %resized = imresize(cropped_img, [270 width], 'Antialiasing', true);
    %resized = imresize(cropped_img, [270 NaN], 'Antialiasing', true);
end
%figure, imshow(resized); title('resized');
%resized = imgaussfilt(resized,2);
%figure, imshow(resized); title('resized after gaussian filter');
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
%K_pad = imopen(K_pad, strel('disk',2));

% d = strel('disk', 5);
% K_pad = imdilate(~K_pad, d);

%Filtered image
Ifilt = imfilter(K_pad,fspecial('gaussian'));


% K_pad = ~K_pad;
% K_pad = bwmorph(K_pad,'thin',inf );
% K_pad = ~K_pad;

% remove some of the noisy edges in the mask.

Ifilt = imgaussfilt(Ifilt, 2);
figure, imshow(Ifilt); title('Ifilt');
