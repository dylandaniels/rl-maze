clear all;

host = getenv('USER');
if strcmp(host(1:4),'paul')
    addpath(genpath('~/Desktop/CS289A/rl-maze/code/'))
else
    addpath(genpath('~/cs289/rl-maze/code/'))
end

nSims = 100;
which_learning_process = 4; % 1=Q-learning, 2=psuedorewards, 3=DYNA, 4=both
do_plot = true;

% Only necessary if which_learning_process == 2
% One of:
%  'optimal_policy', 'manhattan', 'optimal_policy_noisy', 'manhattan_noisy'

which_pseudorewards = {'manhattan'};

grafica     = false; % indicates if display the graphical interface

which_maze = 'sparse';
switch which_maze
    
    case 'default'
        
        start       = [0 3]; % column, row (zero indexing)
        goal        = [8 5]; % column, row (zero indexing)
        [maze, N, M, reward_landscape]  = CreateMaze(which_maze); % maze is also: column, row
        
    case 'losses'
        
        start       = [0 3];
        goal        = [8 5; 8 0];
        [maze, N, M, reward_landscape]  = CreateMaze(which_maze);
        
    case 'dense'
        
        [~, ~, ~, reward_landscape]  = CreateMaze(which_maze);
        load 11maze.mat
        start = start_m;
        goal = goal_m;
        maze = m;
        M = size(maze,1);
        N = size(maze,2);
        if ~all(size(reward_landscape)==size(m))
            error('reward landscape wrong size-- fix CreateMaze')
        end
    
    case 'sparse'
        
        [~, ~, ~, reward_landscape]  = CreateMaze(which_maze);
        load 11maze_sparse.mat
        start = start_m;
        goal = goal_m;
        maze = m;
        M = size(maze,1);
        N = size(maze,2);
        if ~all(size(reward_landscape)==size(m))
            error('reward landscape wrong size-- fix CreateMaze')
        end
        
end

statelist   = BuildStateList(N,M);  % the list of states
actionlist  = BuildActionList(); % the list of actions

nstates     = size(statelist,1);
nactions    = size(actionlist,1);

%Generate initial Population
Q           = BuildQTable(nstates, nactions); % the Qtable  
Model       = BuildModel(nstates, nactions); % the Qtable   

% planning steps
p_steps     = 20;

maxepisodes = 50; % maximum number of episodes
maxsteps    = 2000;  % maximum number of steps per episode
alpha       = 0.1;   % learning rate
gamma       = 0.95;  % discount factor
epsilon     = 0.25;   % probability of a random action selection
sigma       = 0;%.05;   % std. dev. for noisy psuedorewards


xpoints=[];
ypoints=[];

% Run it!
pseudoreward_maze

if do_plot
    plot_stepsAndReward_vs_episode
end