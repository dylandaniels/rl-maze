function nonWallActions = get_wallActions(maze)

mazeWall = ones(size(maze,1)+2,size(maze,2)+2);
mazeWall(2:end-1,2:end-1) = maze;

vecPos = flipud(mazePos2vecPos(size(maze,1),size(maze,2),[]));

nonWallActions = cell(numel(maze),1);
for r = 1:size(maze,1)
    for c = 1:size(maze,2)
        
        rr = r+1; % rows of mazeWall
        cc = c+1; % columns of maze wall
        isWall(1) = mazeWall(rr-1,cc) == 1; % up
        isWall(2) = mazeWall(rr,cc+1) == 1; % right
        isWall(3) = mazeWall(rr+1,cc) == 1; % down
        isWall(4) = mazeWall(rr,cc-1) == 1; % left
        
        nonWallActions{vecPos(r,c)} = find(~isWall);
        
    end
end

