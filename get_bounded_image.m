function  cropped_img= get_bounded_image(rotated_img, padding)

PADDING = padding;
rotated_img_with_noise = rotated_img;

rotated_img = ~rotated_img;
rotated_img = imclearborder(rotated_img,4);
rotated_img = bwareaopen(rotated_img, 50);
rotated_img = ~rotated_img;

[row, column] = find(rotated_img == 0);
cropped_img = imcrop(rotated_img_with_noise, [min(column)- PADDING , min(row) - PADDING, (max(column) - min(column)) + 2* PADDING , (max(row) - min(row)) + 2* PADDING]);


