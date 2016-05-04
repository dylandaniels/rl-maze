function vecPos = mazePos2vecPos(M,N)
% convert maze position from matrix form to vector form...
vec = 1:(M*N);
vecPos = reshape(vec,[M N]);