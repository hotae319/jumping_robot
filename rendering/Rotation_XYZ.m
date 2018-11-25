function [ output_args ] = Rotation_XYZ( input_args, axis_ )
%Rotation matrix function for X,Y,Z direction
%   first argument : angle, second argument :  axis. i.e.,
%   Rotation_XYZ(0.1, 'x') -rotation 0.1 rad along the x axis

switch lower(axis_)
    case 'x'
        temp_rotation =  [1 0 0; 0, cos(input_args), -sin(input_args); 0, sin(input_args), cos(input_args)];
    case 'y'
        temp_rotation =  [cos(input_args) 0 sin(input_args); 0, 1, 0; -sin(input_args), 0, cos(input_args)];
    case 'z'
        temp_rotation =  [cos(input_args) -sin(input_args) 0; sin(input_args), cos(input_args), 0; 0, 0, 1];
end
output_args = temp_rotation; 

end

