function [ maze ] = makeMazeModified(n)


maze = makeMaze(n);
maze = (maze == 2);
maze = maze(3:end-2, 3:end-2);

end

