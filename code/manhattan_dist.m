function [ shaping ] = manhattan_dist(maze, goal, gamma)
%MANHATTAN_DIST shaping function
% maze is a binary matrix
% goal is expressed in [col, row] starting from bottom-left
%       and is zero-indexed

nrows = size(maze, 1);
ncols = size(maze, 2);

% one-indexed goal which aligns with human intuition
%   in (row, col) format
intuitive_goal = [nrows - goal(2), goal(1) + 1];

shaping = zeros(nrows, ncols);
for i = 1:nrows
    for j = 1:ncols
        shaping(i,j) = gamma.^sum(abs([i j] - intuitive_goal));
    end
end


end