function  max_height= get_max_height(image)

cropped_img = image;
[rows, columns] = size(cropped_img);
YL = [];
XL = [];
% go across columns of image looking for last white pixel in the column.
for col = 1 : columns
    column_data = cropped_img(:,col);
    lowermost_pixel = find(column_data == 0, 1, 'last');
    if ~isempty(lowermost_pixel)
        %display('Non empty column found');
        XL = [XL; col];
        YL = [YL; lowermost_pixel];
    %else
        %display('Empty column found');
    end
end

YH = [];
XH = [];
% go across columns of image looking for last white pixel in the column.
for col = 1 : columns
    column_data = cropped_img(:,col);
    lowermost_pixel = find(column_data == 0, 1, 'first');
    if ~isempty(lowermost_pixel)
        %display('Non empty column found');
        XH = [XH; col];
        YH = [YH; lowermost_pixel];
    %else
    %    display('Empty column found');
    end
end


diff = (-1)*(YH - YL) + 1;

% p = polyfit(XH, diff, 1);
% 
% plot(XH,YH,'*',1:0.1:230,polyval(p,1:0.1:230),'-')
% 
% angle = atan(p(1))*(-1);
% angle_deg = radtodeg(atan(p(1))*(-1))

max_height = max(diff);