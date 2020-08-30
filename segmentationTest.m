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
sample_message_num = 2900;
sample_message = scan_msg_structs{sample_message_num};
tolerance = 1.0; % set a tolerance value (in meters)
seg = lidarSegmentation2D(sample_message.Ranges, sample_message.AngleMin, sample_message.AngleMax, tolerance);  

hold on
grid on

% original data
ranges = scan_msg_structs{sample_message_num}.Ranges;
angles = linspace(scan_msg_structs{sample_message_num}.AngleMin, scan_msg_structs{sample_message_num}.AngleMax, numel(scan_msg_structs{sample_message_num}.Ranges));
plot(angles, ranges, 'LineWidth', 3);


% segmented data
for s = seg
    plot(s{1}(2,:),s{1}(1,:), 'LineWidth', 5);
end

hold off