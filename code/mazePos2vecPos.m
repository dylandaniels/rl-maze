function vecPos = mazePos2vecPos(M,N,start)
% convert maze position from matrix form to vector form...

% vec = [M*N-(start(2)-start(1)*M)+1:M*N, 1:M*N-(start(2)-start(1)*M)];
vec = [1:M*N];
vecPos = reshape(vec,[M N]);