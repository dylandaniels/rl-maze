function [ a ] = GetBestAction_noWalls( Q, s, nonWallActions )
% GetBestAction return the best action for state (s)
% Q: the Qtable
% s: the current state
% Q has structure  Q(states,actions)


% must do a trick in order to avoid the selection of the same action when two or more actions
% have the same value.


[v idx]    = sort(Q(s,nonWallActions{s}),'descend');
x          = diff(v);
i          = find(x,1);

if isempty(i)
    a = randsample(nonWallActions{s},1);
else
    % i is the number of equal elements
    j = randi(i);
    
    % idx(j) is the jth index in sorted idx, thus a=idx(j) some of the best
    % (equal values) actions
    a = idx(j);
    a = nonWallActions{s}(a);
end
end