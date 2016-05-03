function [ a ] = e_greedy_selection_noWalls( Q , s, epsilon, nonWallActions )
% e_greedy_selection selects an action using Epsilon-greedy strategy
% Q: the Qtable
% s: the current state



if (rand()>epsilon)
    a = GetBestAction_noWalls(Q,s,nonWallActions);
else
    % selects a random action based on a uniform distribution
    % +1 because randint goes from 0 to N-1 and matlab matrices goes from
    % 1 to N
    a = randsample(nonWallActions{s},1);
end

