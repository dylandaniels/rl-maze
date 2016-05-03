function reward_landscape = get_reward_landscape(which_maze)

if nargin < 1
    which_maze = 'default';
    disp('using the default reward landscape')
end

switch which_maze
    
    case 'default'
        
        reward_landscape = zeros(6,9);
        reward_landscape(1,9) = 1;
        
    case 'losses'
        
        reward_landscape = zeros(6,9);
        reward_landscape(1,9) = 5;
        reward_landscape(1,8) = -1;
        reward_landscape(2,9) = -1;
        reward_landscape(6,9) = 10;
        reward_landscape(5,9) = -2;
        reward_landscape(6,8) = -2;
        
    case 'big'
        
        reward_landscape = zeros(50,50);
        reward_landscape(1,9) = 1;
        
    otherwise
        error('unrecognized maze type')
        
end