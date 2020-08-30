clear
clc

% get bag
rosbag_path = 'rosbags/my_bag3.bag';
my_bag = rosbag(rosbag_path);

% select odometry and scan messages
scan_topic = '/scan';
odom_topic = '/odom';

scan_msgs = select(my_bag, 'Topic', scan_topic);
scan_msg_structs = readMessages(scan_msgs,'DataFormat','struct');

odom_msgs = select(my_bag, 'Topic', odom_topic);
odom_msg_structs = readMessages(odom_msgs,'DataFormat','struct');

% pick a scan message for test
first_message = scan_msg_structs{1};
tolerance = 1.0; % set a tolerance value
seg = lidarSegmentation2D(first_message.Ranges, first_message.AngleMin,first_message.AngleMax, tolerance);  

hold on
grid on

% original data
ranges = scan_msg_structs{1}.Ranges;
angles = linspace(scan_msg_structs{1}.AngleMin, scan_msg_structs{1}.AngleMax, numel(scan_msg_structs{1}.Ranges));
plot(angles, ranges, 'LineWidth', 3);


% segmented data
for sg = seg
    plot(sg{1}(2,:),sg{1}(1,:), 'LineWidth', 5);
end

hold off