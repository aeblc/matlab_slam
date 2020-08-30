function [segmented_data] = lidarSegmentation2D(lidar_ranges, lidar_angle_min, lidar_angle_max, distance_tolerance)
    %LIDARSEGMENTATION2D Creates segmentations of lidar data
    %   Creates segmentations of 2D lidar data, points within the 
    %   distance_tolerance are considered in the same group
    
    lidar_data_count = numel(lidar_ranges);  % same as lidar_angles length
    
    % build lidar_angles here, consumes less memory
    lidar_angles = linspace(lidar_angle_min,lidar_angle_max,lidar_data_count);
    
    group_list = {};
    group_elements = zeros(2,1);
    grouped_element_count = 0;
    
    for i = 1:lidar_data_count-1
        
        if i == 1
            group_elements(1,1) = lidar_ranges(1);
            group_elements(2,1) = lidar_angles(1);
        end
        
        if abs(lidar_ranges(i) - lidar_ranges(i+1)) <= distance_tolerance 
            group_elements(1,i+1 - grouped_element_count) = lidar_ranges(i+1);
            group_elements(2,i+1 - grouped_element_count) = lidar_angles(i+1);
        else
            group_list{end+1} = group_elements;
            group_elements = zeros(2,1);
            group_elements(1,1) = lidar_ranges(i+1); 
            group_elements(2,1) = lidar_angles(i+1);
            grouped_element_count = i;
        end
    
    end
    
    % get the last group
    group_list{end+1} = group_elements;
    
    segmented_data = group_list;
end

