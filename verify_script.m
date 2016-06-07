function result= verify_script(img0, img1, img2, img3, img4, img5)
% accept 5 images of the signature plus the signature to be verified
% returns percentage probability of the signature being authentic.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%PARTIAL GRAVITY SLOPE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

s1 = get_partial_gravity_slope(get_rotated_image(img1))

s2 = get_partial_gravity_slope(get_rotated_image(img2))

s3 = get_partial_gravity_slope(get_rotated_image(img3))

s4 = get_partial_gravity_slope(get_rotated_image(img4))

s5 = get_partial_gravity_slope(get_rotated_image(img5))

partial_gravity_slopes = [s1; s2; s3];

mean_ = mean(partial_gravity_slopes)
standard_deviation = std(partial_gravity_slopes)

s0 = get_partial_gravity_slope(get_rotated_image(img0))

euclidian_distance =(( s0 -mean_)/standard_deviation)^2 ;

result= euclidian_distance;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%COLUMN GRAVITY SLOPE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% s1 = get_column_gravity_slope(get_rotated_image(img1))
% 
% s2 = get_column_gravity_slope(get_rotated_image(img2))
% 
% s3 = get_column_gravity_slope(get_rotated_image(img3))
% 
% s4 = get_column_gravity_slope(get_rotated_image(img4))
% 
% s5 = get_column_gravity_slope(get_rotated_image(img5))
% 
% column_gravity_slopes = [s1; s2; s3];
% 
% mean_ = mean(column_gravity_slopes)
% standard_deviation = std(column_gravity_slopes)
% 
% s0 = get_column_gravity_slope(get_rotated_image(img0))
% 
% euclidian_distance =(( s0 -mean_)/standard_deviation)^2 ;
% 
% result= euclidian_distance;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%HEIGHT SLOPE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% s1 = get_height_slope(get_bounded_image(get_rotated_image(img1), 7))
% 
% s2 = get_height_slope(get_bounded_image(get_rotated_image(img2), 7))
% 
% s3 = get_height_slope(get_bounded_image(get_rotated_image(img3), 7))
% 
% s4 = get_height_slope(get_bounded_image(get_rotated_image(img4), 7))
% 
% s5 = get_height_slope(get_bounded_image(get_rotated_image(img5), 7))
% 
% height_slopes = [s1; s2; s3];
% 
% mean_ = mean(height_slopes)
% standard_deviation = std(height_slopes)
% 
% s0 = get_height_slope(get_bounded_image(get_rotated_image(img0), 7))
% 
% euclidian_distance =(( s0 -mean_)/standard_deviation)^2 ;
% 
% result= euclidian_distance;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%HEIGHT NORMALIZED   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% s1 = get_max_height(get_bounded_image(get_rotated_image(img1), 7))/get_max_height(imrotate(get_bounded_image(get_rotated_image(img1), 7), 90));
% 
% s2 = get_max_height(get_bounded_image(get_rotated_image(img2), 7))/get_max_height(imrotate(get_bounded_image(get_rotated_image(img2), 7), 90));
% 
% s3 = get_max_height(get_bounded_image(get_rotated_image(img3), 7))/get_max_height(imrotate(get_bounded_image(get_rotated_image(img3), 7), 90));
% 
% s4 = get_max_height(get_bounded_image(get_rotated_image(img4), 7))/get_max_height(imrotate(get_bounded_image(get_rotated_image(img4), 7), 90));
% 
% s5 = get_max_height(get_bounded_image(get_rotated_image(img5), 7))/get_max_height(imrotate(get_bounded_image(get_rotated_image(img5), 7), 90));
% 
% height_normalized = [s1; s2; s3];
% 
% mean_ = mean(height_normalized);
% standard_deviation = std(height_normalized);
% 
% s0 = get_max_height(get_bounded_image(get_rotated_image(img0), 7))/get_max_height(imrotate(get_bounded_image(get_rotated_image(img0), 7), 90));
% 
% euclidian_distance =(( s0 -mean_)/standard_deviation)^2 ;
% 
% result= euclidian_distance;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%ROTATION AND ROOF DIFF   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% s1 = get_rotation_angle(img1) - get_roof_angle(img1);
% 
% s2 = get_rotation_angle(img2) - get_roof_angle(img2);
% 
% s3 = get_rotation_angle(img3) - get_roof_angle(img3);
% 
% s4 = get_rotation_angle(img4) - get_roof_angle(img4);
% 
% s5 = get_rotation_angle(img5) - get_roof_angle(img5);
% 
% angle_diff = [s1; s2; s3];
% 
% mean_ = mean(angle_diff);
% standard_deviation = std(angle_diff);
% 
% s0 = get_rotation_angle(img0) - get_roof_angle(img0);
% 
% euclidian_distance =(( s0 -mean_)/standard_deviation)^2 ;
% 
% result= euclidian_distance;
