function [transition_matrix, reward_matrix] = get_transitionAndReward_matrices(statelist,actionlist,maze,M,N,start,goal,reward_landscape)
% from statelist and actionlist, generate an MDP transition matrix
% states begin at "start" and proceed bottom to top and left to right
% through the maze, then wrap around to [0 0] and end just before start
% NOTE: not currently setup for non-deterministic transitions
%
% M: number of rows in maze
% N: number of columns in maze

if size(actionlist,2) ~= 1
    error('actionlist must be a column vector')
end

nstates     = size(statelist, 1);
nactions    = size(actionlist, 1);

transition_matrix = zeros(nstates, nstates, nactions); 
reward_matrix = zeros(nstates, nactions); 

mazePosition2vectorPosition = mazePos2vecPos(M,N,start);
for i = 1:size(goal,1)
    terminal_state(i) = mazePosition2vectorPosition(goal(i,2)+1,goal(i,1)+1);
end

for action = actionlist'
    for i = 0:N-1 % i is over columns
        for j = 0:M-1 % j is over rows
            x = [i j]; % postion: column, row, with 0 indexing
            xp = DoAction(action,x,maze);
            [reward, finished] = GetReward(xp,goal,reward_landscape);
            x = mazePosition2vectorPosition(x(2)+1,x(1)+1);
            xp = mazePosition2vectorPosition(xp(2)+1,xp(1)+1);
            transition_matrix(x,xp,action) = 1; % if we do non-deterministic transitions, this has to change
            reward_matrix(xp,action) = reward;
            if finished
                if ~any(xp == terminal_state)
                    error('sanity check: something is askew')
                end
            end
        end
    end
end
for i = 1:size(goal,1)
    transition_matrix(terminal_state(i),:,:) = 0;
end
ix = find(rot90(maze));
mat = flipud(mazePosition2vectorPosition);
wall_ind = mat(ix);
transition_matrix(wall_ind,:,:) = 0;
    