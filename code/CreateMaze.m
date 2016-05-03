function [ maze,nrows,ncols, reward_landscape ] = CreateMaze(which_maze)
%CREATEMAZE Summary of this function goes here
%   Detailed explanation goes here

if nargin < 1
    which_maze = 'default';
    disp('making the default maze')
end

switch which_maze
    
    case 'default'
        nrows = 9;
        ncols = 6;
        maze = zeros(nrows,ncols);
        %Add some obstacles
        maze(3,3:5) =1;
        maze(6,2)   =1;
        maze(8,4:6) =1;
        
        % the coordinates of this are in standard matrix form (rows start at the
        % top, etc.)
        reward_landscape = zeros(6,9);
        reward_landscape(1,9) = 1;
        
    case 'losses'
        nrows = 9;
        ncols = 6;
        maze = zeros(nrows,ncols);
%         maze(3,3:5) =1;
%         maze(6,2)   =1;

        reward_landscape = zeros(6,9);
        reward_landscape(1,9) = 5;
        reward_landscape(1,8) = -1;
        reward_landscape(2,9) = -1;
        reward_landscape(6,9) = 10;
        reward_landscape(5,9) = -2;
        reward_landscape(6,8) = -2;
        
    case 'big'        
        
        nrows = 11;
        ncols = 11;
        maze = nan;
        
        reward_landscape = zeros(11,11);
        reward_landscape(11,11) = 1;
        
    otherwise
        error('unrecognized maze type')
end

end

