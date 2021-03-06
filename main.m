% main file to produce train and test data in csv format for Neural Network
databaseFolder = 'train';
trainFolder = 'test';

imagesPerUser = 5;
noOfUsers = 13;

%#############################################################################################
% prepare csv file to save 

filename = 'file.csv'; 
fileID = fopen(filename,'wt');

A ={'imageId', 'image1', 'image2', 'partial_gravitiy_slope', 'colomun_gravity_slope', 'get_height_slope', 'get_max_height', 'rotation_and_roof_diff', 'same_or_fraud'}; %'

%write heading string to csv
[rows, columns] = size(A);
for index = 1:rows    
    fprintf(fileID, '%s,', A{index,1:end-1});
    fprintf(fileID, '%s\n', A{index,end});
end 

fclose(fileID);

%#############################################################################################
% prepare vector cell array
vec_imageId = [];
vec_image_pair_1 = [];
vec_image_pair_2 = [];
vec_partial_gravity_slope = [];
vec_column_gravity_slope = [];
vec_get_height_slope = [];
vec_get_max_height = [];
vec_rotation_and_roof_diff = [];
same_or_fraud = [];
%#############################################################################################

% loop through the 13 set of images
for cntUser= 1 : noOfUsers
    
    % get a person's set of signature images (for now its 5 true images)
    train_images = {};
    test_images = {};
    fake_images = {};
    
    name_start = strcat(int2str(cntUser), '_00');
    for k = 0 : (imagesPerUser -1)
        file_name = strcat('train/', name_start, int2str(k), '.png');
        train_images{k+1} = imread(file_name);
    end

    %for k = 0 : (imagesPerUser -1)
    %    file_name = strcat('test/', name_start, int2str(k), '.png');
    %    test_images{k+1} = imread(file_name);
    %end
    
    % get image pair names to fill in the first colomun 
    for i= 1 : imagesPerUser
        for j= 2 : imagesPerUser
            if(j>i)
                vec_imageId = [vec_imageId; cntUser];
                vec_image_pair_1 = [vec_image_pair_1; i];
                vec_image_pair_2 = [vec_image_pair_2; j];
                same_or_fraud = [same_or_fraud; 1];
            end
        end
    end
    
    % now apply the algorithms every pair of the images to get the eucleadian distance
    [result_partial_gravity_slope, result_column_gravity_slope, result_get_height_slope, ...
    result_get_max_height, result_rotation_and_roof_diff] = extract_features(train_images{1},...
    train_images{2}, train_images{3}, train_images{4}, train_images{5}, imagesPerUser);

    %[result_partial_gravity_slope, result_column_gravity_slope, result_get_height_slope, ...
    %result_get_max_height, result_rotation_and_roof_diff]
    
    vec_partial_gravity_slope = [vec_partial_gravity_slope; result_partial_gravity_slope];
    vec_column_gravity_slope = [vec_column_gravity_slope; result_column_gravity_slope];
    vec_get_height_slope = [vec_get_height_slope; result_get_height_slope];
    vec_get_max_height = [vec_get_max_height; result_get_max_height];
    vec_rotation_and_roof_diff = [vec_rotation_and_roof_diff; result_rotation_and_roof_diff];
    
end

%#############################################################################################
% write the data to the csv file 
%vec_image_pair_name   
d = [vec_imageId, vec_image_pair_1, vec_image_pair_2, vec_partial_gravity_slope, vec_column_gravity_slope,...
    vec_get_height_slope, vec_get_max_height, vec_rotation_and_roof_diff, same_or_fraud];

dlmwrite(filename, d,'-append', 'delimiter', ',');
 
