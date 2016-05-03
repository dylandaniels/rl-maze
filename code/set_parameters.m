addpath(genpath('~/Dropbox/CS289_finalProject/'))

which_maze = 'losses';
switch which_maze
    
    case 'default'
        
        start       = [0 3]; % column, row (zero indexing)
        goal        = [8 5]; % column, row (zero indexing)
        [maze, N, M, reward_landscape]  = CreateMaze(which_maze); % maze is also: column, row
        
    case 'losses'
        
        start       = [0 3];
        goal        = [8 5; 8 0];
        [maze, N, M, reward_landscape]  = CreateMaze(which_maze);
        
    case 'big'
        
        [maze, N, M, reward_landscape]  = CreateMaze(which_maze);
        load 10maze.mat
        start = start_m;
        goal = goal_m;
        maze = m;
        
end

statelist   = BuildStateList(N,M);  % the list of states
actionlist  = BuildActionList(); % the list of actions

nstates     = size(statelist,1);
nactions    = size(actionlist,1);

%Generate initial Population
Q           = BuildQTable(nstates,nactions ); % the Qtable  
Model       = BuildModel(nstates,nactions ); % the Qtable   

% planning steps
p_steps     = 10;

maxepisodes = 50; % maximum number of episodes
maxsteps    = 2000;  % maximum number of steps per episode
alpha       = 0.1;   % learning rate
gamma       = 0.95;  % discount factor
epsilon     = 0.1;   % probability of a random action selection


grafica     = true; % indicates if display the graphical interface
xpoints=[];
ypoints=[];